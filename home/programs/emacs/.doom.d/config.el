;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Font
(setq doom-font (font-spec :family "Fira Code" :size 15))


;; Theme
(setq doom-theme 'doom-peacock)

(after! doom-themes
  (setq doom-modeline-major-mode-icon t))

(setq evil-normal-state-cursor '(box "DarkGoldenrod1")
      evil-insert-state-cursor '(bar "DarkGoldenrod1")
      evil-visual-state-cursor '(hollow "DarkGoldenrod1")
      evil-operator-state-cursor '(evil-half-cursor "DarkGoldenrod1"))


;; evil-escape-key-sequence
(setq evil-escape-key-sequence "fd")


;; web-mode
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(after! web-mode
  (setq web-mode-enable-auto-pairing nil))

(sp-with-modes '(web-mode)
  (sp-local-pair "%" "%" :post-handlers '(("| " "SPC")))
  (sp-local-pair "=" "" :post-handlers '(("| " "SPC"))))

(sp-local-pair 'web-mode "<" ">" :actions nil)

(add-hook 'web-mode-hook 'emmet-mode)

(map! (:after web-mode
        (:map web-mode-map
          "TAB" nil
          "TAB" 'emmet-expand-yas)))


;; Company
(add-hook 'text-mode-hook 'global-company-mode)

(setq company-idle-delay 0.2
      company-minimum-prefix-length 2)

(map! (:after company
        (:map company-active-map
          "<tab>" nil
          "TAB" 'company-complete-selection)))


;; Org-Latex
(setq org-latex-packages-alist
      '(("AUTO" "babel" t)
        ("T2A" "fontenc" t)))


;; term
(defun current-directory()
  "Returns current directory"
  (file-name-directory (buffer-file-name)))

(defun term-send-cd()
  (term-send-string
    (get-buffer-process "*terminal*")
    (format "cd %s\n%s\n" (current-directory) "clear")))

(defun open-terminal()
  "Opens terminal in a new window"
  (interactive)
  (cond
   ((not (get-buffer-window "*terminal*"))
    (progn
      (pop-to-buffer (save-window-excursion (+term/here))
                     (evil-window-set-height 15)))

    (t (progn
         (term-send-cd)
         (select-window (get-buffer-window "*terminal*")))))))

(defun open-popup-terminal()
  (interactive)
  (+term/toggle t)
  (evil-window-set-height 15))


;; Trello
(defun org-trello-sync-buffer-from-trello()
  (interactive)
  (org-trello-sync-buffer t))


;; <leader>
(map! :leader
      :desc "Open swiper" "S" 'swiper
      :desc "Toggle terminal in popup" "o t" 'open-popup-terminal
      :desc "Open mu4e" "m" 'mu4e)


;; python
(add-hook 'python-mode-hook (λ! (electric-indent-local-mode -1)))
;; (setq pylint-options '("--rcfile=~/.config/pylint/pylintrc"))
(setq flycheck-pylintrc "~/.config/pylint/pylintrc")


;; snippets
(require 'yasnippet)
(doom-snippets-initialize)


;; flycheck
(setq-default flycheck-disabled-checkers
              '(python-flake8
                python-pycompile
                python-mypy))


;; agenda
(setq org-agenda-files '("~/Documents/org/"))

(setq org-agenda-custom-commands
      '(("c" "Custom agenda view"
         ((agenda ""
                  ((org-agenda-overriding-header "Today's agenda")
                   (org-agenda-start-day "4d")
                   (org-agenda-span 1)))
          (agenda "" ((org-agenda-overriding-header "10 days' agenda")))
          (alltodo "" ((org-agenda-overriding-header "All tasks")))))))


;; ligatures
(when (featurep! :ui pretty-code)
  (after! org
    (set-pretty-symbols! 'org-mode
      :name "#+NAME:"
      :src_block "#+BEGIN_SRC"
      :src_block_end "#+END_SRC"
      :alist '(("[ ]" . "")
               ("[X]" . "")
               ("[-]" . "")
               ("SCHEDULED:" . "")
               ("DEADLINE:" . "")
               ("#+begin_src" . "«")
               ("#+end_src" . "»")))))


;; plantuml
(setq org-plantuml-jar-path
      (expand-file-name "/usr/share/java/plantuml/plantuml.jar"))


;; mu4e
;; (after! mu4e
;;   (setq mu4e-get-mail-command "/home/yevhens/.local/bin/offlineimap.sh"
;;         mu4e-update-interval 300
;;         send-mail-function (quote smtpmail-send-it)
;;         smtpmail-smtp-server "smtp.gmail.com"
;;         smtpmail-smtp-service 587))

;; (mu4e-alert-set-default-style 'libnotify)
;; (add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
;; (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)


;; magit
(add-hook 'magit-mode-hook 'magit-todos-mode)

(setq org-directory "~/org")


;; lsp
(setq lsp-dart-sdk-dir "/nix/store/w114n09zpyjy6dnry7mghwyiiz407d68-dart-2.7.1")

(use-package! lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  (elixir-mode . 'lsp)
  :init
  (add-to-list
   'exec-path
   (concat (getenv "HOME") "/dev/elixir/elixir-ls/release")))

;; go
(add-to-list
   'exec-path
   (concat (getenv "HOME") "/go/bin"))
