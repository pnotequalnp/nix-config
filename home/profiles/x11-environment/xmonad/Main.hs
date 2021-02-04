{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -fno-show-valid-hole-fits #-}
{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE ParallelListComp #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Control.Lens
import Data.Foldable (fold)
import Data.List (intercalate)
import Data.Monoid (Ap(..))
import Data.Map (Map)
import qualified Data.Map as M
import System.Process (readProcess)
import XMonad.Actions.Submap (submap)
import XMonad
  ( KeySym, X, Layout, Full, Mirror, Tall, Choose, XConfig, ButtonMask
  , (=?), (.|.), spawn , def, mod4Mask, xmonad, liftIO
  )
import qualified XMonad as X
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.SetWMName (setWMName)
import qualified XMonad.StackSet as SS
import XMonad.Hooks.ManageHelpers (composeOne, (-?>), transience, isFullscreen, doFullFloat)

main :: IO ()
main = xmobar config >>= xmonad

config :: XConfig (Choose Tall (Choose (Mirror Tall) Full))
config = ewmh def
  { X.terminal = "alacritty"
  , X.modMask  = mod4Mask
  , X.keys     = keys
  , X.mouseBindings = const []
  , X.workspaces = workspaces
  , X.manageHook = manageHook
  }

manageHook :: X.ManageHook
manageHook = fold @[] [spawnHook, X.manageHook def]
  where
  spawnHook = composeOne
    [ isFullscreen -?> doFullFloat
    , transience
    , X.className =? "discord" -?> X.doShift "18"
    , X.className =? "zoom" -?> X.doShift "17"
    ]

workspaces :: [String]
workspaces = [0..19] <&> show @Int

keys :: XConfig Layout -> Map (ButtonMask, KeySym) (X ())
keys X.XConfig { X.terminal = term, X.modMask = modm } = toKeymap . addMod [modm] $
  [ ([], X.xK_Return)              ## spawn term
  , ([], X.xK_space)               ## submap' runKeys
  , ([], X.xK_Tab)                 ## submap' systemKeys
  , ([X.controlMask], X.xK_Escape) ## X.kill

  , ([], X.xK_j)                   ## X.windows SS.focusDown
  , ([], X.xK_k)                   ## X.windows SS.focusUp
  , ([X.shiftMask], X.xK_j)        ## X.windows SS.swapDown
  , ([X.shiftMask], X.xK_k)        ## X.windows SS.swapUp
  , ([], X.xK_h)                   ## X.sendMessage X.Shrink
  , ([], X.xK_l)                   ## X.sendMessage X.Expand
  
  , ([], X.xK_BackSpace) ## X.sendMessage X.NextLayout
  ] <> workspaceKeys X.controlMask <> dunstKeys
  where
  submap' = submap . toKeymap . addMod [modm]

workspaceKeys :: ButtonMask -> Map ([ButtonMask], KeySym) (X ())
workspaceKeys alt = fold
  [ [ ([], k)                 ## X.windows (SS.greedyView x)
    , ([X.shiftMask], k)      ## X.windows (SS.shift x)
    , ([alt], k)              ## X.windows (SS.greedyView y)
    , ([alt, X.shiftMask], k) ## X.windows (SS.shift y)
    ]
  | x <- [0..9] <&> show @Int
  | y <- [10..19] <&> show @Int
  | k <- [X.xK_0..X.xK_9]
  ]

dunstKeys :: Map ([ButtonMask], KeySym) (X ())
dunstKeys =
  [ ([], X.xK_backslash)              ## spawn "dunstctl close"
  , ([X.shiftMask], X.xK_backslash)   ## spawn "dunstctl history-pop"
  , ([X.controlMask], X.xK_backslash) ## spawn "dunstctl close-all"
  ]

runKeys :: Map ([ButtonMask], KeySym) (X ())
runKeys =
  [ ([], X.xK_space)               ## spawn "rofi -show drun"
  , ([X.shiftMask], X.xK_space)    ## spawn "rofi -show run"
  , ([], X.xK_Return)              ## spawn "chromium"
  , ([X.controlMask], X.xK_Return) ## spawn "chromium --incognito"
  , ([], X.xK_d)                   ## spawn "Discord"
  , ([], X.xK_e)                   ## spawn "emacsclient -c"
  ]

systemKeys :: Map ([ButtonMask], KeySym) (X ())
systemKeys =
  [ ([], X.xK_space)     ## rofi "System" options
  , ([], X.xK_Return)    ## screenshot
  , ([], X.xK_Tab)       ## spawn "rofi -show window"
  , ([], X.xK_BackSpace) ## X.sendMessage X.NextLayout
  , ([], X.xK_r)         ## restart
  , ([], X.xK_b)         ## btConnect
  ]
  where
  restart = spawn "killall xmobar && xmonad --restart"
  screenshot = spawn "flameshot gui"
  btConnect = spawn "bluetoothctl connect D8:55:75:9F:29:1B" -- Galaxy Buds
  options =
    [ "Restart"            ## restart
    , "Recompile"          ## spawn "xmonad --recompile && killall xmobar && xmonad --restart"
    , "Reboot"             ## spawn "reboot"
    , "Connect Headphones" ## btConnect
    ]

rofi :: String -> Map String (X ()) -> X ()
rofi name options = do
  -- TODO: This doesn't work (spawned rofi isn't interactive)
  res <- liftIO $ readProcess "rofi" ["-dmenu", "-i", "-p", name] input
  let act = M.lookup res options
  ala Ap foldMap act
  where
  input = intercalate "\n" $ M.keys options

toKeymap :: Ord k => Map ([ButtonMask], k) a -> Map (ButtonMask, k) a
toKeymap = M.mapKeys $ _1 %~ foldr (.|.) 0

addModifiers :: (Ord k1, Ord k2, Monoid k1)
             => [k1]
             -> Map (k1, k2) a
             -> Map (k1, k2) a
addModifiers mods keymap = M.unions $ f <$> mods
  where f = flip M.mapKeys keymap . (_1 <>~)

addMod :: (Ord k1, Ord k2, Monoid k1) => k1 -> Map (k1, k2) a -> Map (k1, k2) a
addMod = addModifiers . pure

(##) :: a -> b -> (a, b)
(##) = (,)
infixr 1 ##
