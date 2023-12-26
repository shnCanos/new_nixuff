(setq doom-theme 'catppuccin)
(setq display-line-numbers-type 'relative)
(setq org-directory "~/Notes/Org")

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
