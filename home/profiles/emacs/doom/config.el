;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(when (daemonp)
  (setq exec-path-from-shell-variables (list "CABAL_DIR" "SSH_AUTH_SOCK"))
  (exec-path-from-shell-initialize))

(setq user-full-name "Kevin Mullins"
      user-mail-address "46154511+pnotequalnp@users.noreply.github.com")

(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 16))

(setq org-directory "$XDG_DATA_HOME/org")

(setq display-line-numbers-type 'visual)

(setq-default fill-column 100)

(add-hook 'pdf-tools-enabled-hook #'pdf-view-midnight-minor-mode)

(after! company
  (map! :map company-active-map
        [tab] #'company-complete-selection
        [return] nil
        "RET" nil))

(after! vterm
  (map! :map vterm-mode-map
        :i "<C-escape>" 'evil-force-normal-state
        :i "<escape>" 'vterm-send-escape
        :i "C-SPC" 'vterm-send-right))

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override t))

(after! evil-snipe
  (setq evil-snipe-scope 'buffer))

(after! rainbow-delimiters (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(setq +format-on-save-enabled-modes nil)

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
