;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input
       ;;chinese
       ;;japanese
       ;;layout            ; auie,ctsrnm is the superior home row

       :completion
       company             ; the ultimate code completion backend
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       ivy                 ; a search engine for love and life

       :ui
       doom                ; what makes DOOM look the way it does
       doom-dashboard      ; a nifty splash screen for Emacs
       doom-quit           ; DOOM quit-message prompts when you quit Emacs
       emoji               ; 🙂
       fill-column         ; a `fill-column' indicator
       hl-todo             ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       minimap             ; show a map of the code on the side
       modeline            ; snazzy, Atom-inspired modeline, plus API
       nav-flash           ; blink cursor line after big motions
       ophints             ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       vc-gutter           ; vcs diff in the fringe
       vi-tilde-fringe     ; fringe tildes to mark beyond EOB
       workspaces          ; tab emulation, persistence & separate workspaces
       ;;deft              ; notational velocity for Emacs
       ;;hydra
       ;;indent-guides     ; highlighted indent columns
       ;;ligatures         ; ligatures and symbols to make your code pretty again
       ;;neotree           ; a project drawer, like NERDTree for vim
       ;;tabs              ; a tab bar for Emacs
       ;;treemacs          ; a project drawer, like neotree but cooler
       ;;unicode           ; extended unicode support for various languages
       ;;window-select     ; visually switch windows
       ;;zen               ; distraction-free coding or writing

       :editor
       (evil +everywhere)
       (file-templates)
       (fold)
       (format +onsave)
       (snippets)
       ;;lispy
       ;;multiple-cursors  ; editing in many places at once
       ;;parinfer          ; turn lisp into python, sort of
       ;;rotate-text       ; cycle region at point between text candidates
       ;;word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired)
       (electric)
       (undo)
       (vc)
       ;;ibuffer           ; interactive buffer management

       :term
       (vterm)

       :checkers
       (syntax)
       ;;spell             ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       (debugger +lsp)
       (direnv)
       (docker)
       (editorconfig)
       (eval +overlay)
       (lookup)
       (lsp +peek +lsp-ui)
       (magit +forge)
       (pdf)
       (rgb)
       ;;ansible
       ;;ein               ; tame Jupyter notebooks with emacs
       ;;gist              ; interacting with github gists
       ;;make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       ;;prodigy           ; FIXME managing external services & code builders
       ;;taskrunner        ; taskrunner for all your projects
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;upload            ; map local to remote projects via ssh/ftp

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       tty                 ; improve the terminal Emacs experience

       :lang
       (cc +lsp)
       (clojure +lsp)
       (dart +flutter +lsp)
       (data)
       (elixir)
       (emacs-lisp)
       (go +lsp)
       (haskell +lsp)
       (idris2)
       (java +lsp)
       (javascript +lsp)
       (json)
       (latex +latexmk +lsp)
       (lean)
       (markdown +grip)
       (nix)
       (org)
       (purescript +lsp)
       (python +lsp +pyright)
       (rust +lsp)
       (scala +lsp)
       (sh)
       (swift +lsp)
       (web)
       (yaml)
       ;;agda              ; types of types of types of types...
       ;;common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       ;;elm               ; care for a cup of TEA?
       ;;erlang            ; an elegant language for a more civilized age
       ;;ess               ; emacs speaks statistics
       ;;factor
       ;;faust             ; dsp, but you get to keep your soul
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;fstar             ; (dependent) types and (monadic) effects and Z3
       ;;gdscript          ; the language you waited for
       ;;hy                ; readability of scheme w/ speed of python
       ;;julia             ; a better, faster MATLAB
       ;;kotlin            ; a better, slicker Java(Script)
       ;;ledger            ; an accounting system in Emacs
       ;;lua               ; one-based indices? one-based indices
       ;;nim               ; python + lisp at the speed of c
       ;;ocaml             ; an objective camel
       ;;php
       ;;plantuml          ; diagrams for confusing people more
       ;;qt                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       ;;raku              ; the artist formerly known as perl6
       ;;rest              ; Emacs as a REST client
       ;;rst               ; ReST in peace
       ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;scheme            ; a fully conniving family of lisps
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       ;;terra             ; Earth and Moon in alignment for performance.

       :email
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       ;;calendar
       ;;irc               ; how neckbeards socialize
       ;;(rss +org)        ; emacs as an RSS reader
       ;;twitter           ; twitter client https://twitter.com/vnought

       :config
       ;;literate
       (default +bindings +smartparens))
