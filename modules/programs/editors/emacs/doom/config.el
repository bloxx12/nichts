;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal information
(setq user-full-name "Charlie Root")
(setq user-mail-address "charlie@charlieroot.dev")

(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Lexend" :size 18))


(setq doom-theme 'catppuccin)

(after! company
  (setq company-idle-delay 0)
  )


;;; :ui modeline
;; An evil mode indicator is redundant with cursor shape
(setq doom-modeline-modal nil)

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;;; :lang org
(setq org-directory "~/Nextcloud/org/"
      org-roam-directory org-directory
      org-roam-db-location (file-name-concat org-directory ".org-roam.db")
      org-roam-dailies-directory "journal/"
      org-contacts-files (file-name-concat org-directory "contacts.org")
      org-archive-location (file-name-concat org-directory ".archive/%s::")
      org-agenda-files (list org-directory))

(after! org
  (setq org-startup-folded 'show2levels
        org-ellipsis " [...] "
        org-capture-templates
        '(("t" "todo" entry (file+headline "todo.org" "Inbox")
           "* [ ] %?\n%i%a"
           :prepend t)
          ("d" "deadline" entry (file+headline "todo.org" "Inbox")
           "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i%a"
           :prepend t)
          ("s" "schedule" entry (file+headline "todo.org" "Inbox")
           "* [ ] %?\nSCHEDULED: <%(org-read-date)>\n\n%i%a"
           :prepend t)
          ("c" "contact" entry (file+headline "contacts.org" "Contacts")
           "%?\n:PROPERTIES:\n:ADDRESS:\n:BIRTHDAY:\n:EMAIL:\n:PHONE:\n:NOTE:\n:END:\n"
           :prepend t)
          ("b" "bookmark" entry (file+headline "bookmarks.org" "Bookmarks")
           "%?\n:PROPERTIES:\n:CREATED:%U\n:END:\n\n"
           :empty-lines 1)
          ("l" "ledger" plain (file "ledger/personal.gpg")
           "%(+beancount/clone-transaction)"))))

;; (after! org-roam
;;   (setq org-roam-capture-templates
;;         `(("n" "note" plain
;;            ,(format "#+title: ${title}\n%%[%s/template/note.org]" org-roam-directory)
;;            :target (file "note/%<%Y%m%d%H%M%S>-${slug}.org")
;;            :unnarrowed t)
;;           ("r" "thought" plain
;;            ,(format "#+title: ${title}\n%%[%s/template/thought.org]" org-roam-directory)
;;            :target (file "thought/%<%Y%m%d%H%M%S>-${slug}.org")
;;            :unnarrowed t)
;;           ("t" "topic" plain
;;            ,(format "#+title: ${title}\n%%[%s/template/topic.org]" org-roam-directory)
;;            :target (file "topic/%<%Y%m%d%H%M%S>-${slug}.org")
;;            :unnarrowed t)
;;           ("c" "contact" plain
;;            ,(format "#+title: ${title}\n%%[%s/template/contact.org]" org-roam-directory)
;;            :target (file "contact/%<%Y%m%d%H%M%S>-${slug}.org")
;;            :unnarrowed t)
;;           ("p" "project" plain
;;            ,(format "#+title: ${title}\n%%[%s/template/project.org]" org-roam-directory)
;;            :target (file "project/%<%Y%m%d>-${slug}.org")
;;            :unnarrowed t)
;;           ("i" "invoice" plain
;;            ,(format "#+title: %%<%%Y%%m%%d>-${title}\n%%[%s/template/invoice.org]" org-roam-directory)
;;            :target (file "invoice/%<%Y%m%d>-${slug}.org")
;;            :unnarrowed t)
;;           ("f" "ref" plain
;;            ,(format "#+title: ${title}\n%%[%s/template/ref.org]" org-roam-directory)
;;            :target (file "ref/%<%Y%m%d%H%M%S>-${slug}.org")
;;            :unnarrowed t)
;;           ("w" "works" plain
;;            ,(format "#+title: ${title}\n%%[%s/template/works.org]" org-roam-directory)
;;            :target (file "works/%<%Y%m%d%H%M%S>-${slug}.org")
;;            :unnarrowed t)
;;           ("s" "secret" plain "#+title: ${title}\n\n"
;;            :target (file "secret/%<%Y%m%d%H%M%S>-${slug}.org.gpg")
;;            :unnarrowed t))
;;         ;; Use human readable dates for dailies titles
;;         org-roam-dailies-capture-templates
;;         `(("d" "default" plain ""
;;            :target (file+head "%<%Y-%m-%d>.org" ,(format "%%[%s/template/journal.org]" org-roam-directory))))))

(after! org-roam
  ;; Offer completion for #tags and @areas separately from notes.
  ;; (add-to-list 'org-roam-completion-functions #'org-roam-complete-tag-at-point)

  ;; Automatically update the slug in the filename when #+title: has changed.
  ;; (add-hook 'org-roam-find-file-hook #'org-roam-update-slug-on-save-h)

  ;; Make the backlinks buffer easier to peruse by folding leaves by default.
  (add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-2)

  ;; List dailies and zettels separately in the backlinks buffer.
  (advice-add #'org-roam-backlinks-section :override #'org-roam-grouped-backlinks-section)

  ;; Open in focused buffer, despite popups
  (advice-add #'org-roam-node-visit :around #'+popup-save-a)

  ;; Make sure tags in vertico are sorted by insertion order, instead of
  ;; arbitrarily (due to the use of group_concat in the underlying SQL query).
  ;; (advice-add #'org-roam-node-list :filter-return #'org-roam-restore-insertion-order-for-tags-a)

  ;; Add ID, Type, Tags, and Aliases to top of backlinks buffer.
  (advice-add #'org-roam-buffer-set-header-line-format :after #'org-roam-add-preamble-a))

;; Fixes since I use fish as my shell
(setq shell-file-name (executable-find "bash"))

(setq-default vterm-shell (executable-find "fish"))
(setq-default explicit-shell-file-name (executable-find "fish"))

;; using the alejandra formatter
(after! nix-mode
  (set-formatter! 'alejandra '("alejandra" "--quiet") :modes '(nix-mode)))
(setq-hook! 'nix-mode-hook +format-with-lsp nil)
(after! good-scroll
  (good-scroll-mode 1))

(after! wakatime-mode
  (global-wakatime-mode))
