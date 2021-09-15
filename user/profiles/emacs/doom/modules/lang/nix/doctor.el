;; -*- lexical-binding: t; no-byte-compile: t; -*-
;;; lang/nix/doctor.el

(unless (executable-find "nix")
  (warn! "Couldn't find the nix package manager. nix-mode won't work."))

(unless (executable-find "rnix-lsp")
  (warn! "Couldn't find rnix-lsp."))
