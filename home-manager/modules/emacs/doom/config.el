;;; $DOOMDIR/config.el -f- lexical-binding: t; -f-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "shnCanos"
;;       user-mail-address "catellacatellacarettacaretta@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-ayu-dark)
;; (setq doom-theme 'doom-ayu-dark)
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Notes/Org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(modify-syntax-entry ?_ "w") ;; _ counts as a word

(after! org
  (setq org-todo-keywords '(
                            (sequence "TODO" "INPROGRESS" "LOWPRIORITY" "|" "DONE" "CANCELLED"))))

(map! :leader
      (:prefix ( "nrl" . "Alias")
       :desc "Add an alias" "a" #'org-roam-alias-add
       :desc "Remove an alias" "r" #'org-roam-alias-remove))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer)
  (setq lsp-rust-analyzer-inlay-hints-mode t)
  (setq lsp-rust-analyzer-server-display-inlay-hints t))

(setq org-roam-directory "~/Notes/.old/Roam")

(after! org-roam
  (setq org-roam-dailies-directory "~/Notes/.old/Roam/dailies"))

(setq doom-font (font-spec
                 :family "JetBrainsMono Nerd Font"
                 :size 15))
;; (setq doom-unicode-font (font-spec :family "Symbola" :size 22 :weight 'Regular))

;;;; org roam ui
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam 
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
(map! :leader
      (:prefix ( "nru" . "ui")
       :desc "Toggle org-roam-ui" "m" #'org-roam-ui-mode
       :desc "open org-roam-ui" "o" #'org-roam-ui-open))

;;;; Org-novelist
;;
(map! :leader
      (:prefix ("en" . "org-novelist")
       :desc "Toggle org-novelist mode" "m" #'org-novelist-mode
       :desc "Export current story" "e" #'org-novelist-export-story
       (:prefix ("n" . "new")
        :desc "new chapter" "n" #'org-novelist-new-chapter
        :desc "new character" "c" #'org-novelist-new-character
        :desc "new story" "s" #'org-novelist-new-story
        :desc "new place" "p" #'org-novelist-new-place
        :desc "new prop" "r" #'org-novelist-new-place)
       (:prefix ("r" . "rename")
        :desc "rename chapter" "n" #'org-novelist-rename-chapter
        :desc "rename character" "c" #'org-novelist-rename-character
        :desc "rename place" "p" #'org-novelist-rename-place
        :desc "rename chapter" "s" #'org-novelist-rename-story
        :desc "rename prop" "o" #'org-novelist-new-place)
       (:prefix ("d" . "destroy")
        :desc "destroy chapter" "n" #'org-novelist-destroy-chapter
        :desc "destroy character" "c" #'org-novelist-destroy-character
        :desc "destroy place" "p" #'org-novelist-destroy-place
        :desc "destroy prop" "o" #'org-novelist-new-place
        :desc "destroy story" "s" #'org-novelist-destroy-story)))

(after! lsp-dart
  (setq lsp-dart-dap-flutter-hot-reload-on-save t))

(after! company
  (setq company-minimum-prefix-length 1))

(setq company-idle-delay 0.3)

(setq company-global-modes '(not text-mode org-mode))
(setq display-line-numbers-type 'visual) ;; For the folds line
