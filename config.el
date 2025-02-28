;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 23)
      doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 23))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; whenever you reconfigure a package, make sure to wrap your config in an
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

(setq-default indent-tabs-mode t)
(setq c-basic-offset 8)

(use-package! spacious-padding-mode
  :hook (+doom-dashboard-mode . spacious-padding-mode))

(use-package! zoom
  :hook (prog-mode . zoom-mode)
  :config
  (setq zoom-size '(0.618 . 0.618))
  (setq zoom-ignored-major-modes '(ediff-mode dired-mode))
  (setq zoom-ignored-buffer-name-regexps '("gud" "locals of" "stack frames of" "breakpoints of" "input/output of" "^\\*Org " "^CAPTURE-")))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (set-face-attribute 'org-modern-symbol nil :family "Iosevka")
  (set-face-attribute 'org-document-title nil :height 1.5)
  (set-face-attribute 'org-document-info nil :height 1.2)

  (set-face-attribute 'org-level-1 nil :height 1.3)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.1)
  (set-face-attribute 'org-level-4 nil :height 1.0)
  (set-face-attribute 'org-level-5 nil :height 0.9))

(after! org-roam
  (setq org-roam-directory (file-truename "~/org"))
  ;; (setq org-roam-graph-link-hidden-types '("file" "http" "https" "fuzzy"))
  (setq org-roam-graph-link-hidden-types '("file"))
  ;; (setq org-roam-graph-viewer "/usr/bin/firefox") -- to return to firefox
  (setq org-roam-graph-viewer nil)
  (setq org-roam-graph-executable "dot"))
(setq org-agenda-files '("~/org/"))
(setq org-latex-title-command "")

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t
	org-roam-ui-open-on-start t))

(use-package! eldoc-box
  :hook (prog-mode . eldoc-box-hover-mode))

(setq +format-with-lsp nil)
(setq lsp-eslint-format nil)

(map! :desc "Comment line" :n "C-/" #'comment-line)
(map! :desc "Comment line" :n "C-;" #'comment-dwim)
(map! :desc "Insert tab char" :i "M-<tab>" '(lambda () (interactive) (insert "	")))
(map! :desc "Scroll right" :ni "C-l" '(lambda () (interactive) (evil-scroll-column-right 15)))
(map! :desc "Scroll left" :ni "C-h" '(lambda () (interactive) (evil-scroll-column-left 15)))
(map! :desc "Other window" :leader :n "ww" #'other-window)

(after! doom-modeline
  (setq doom-modeline-height 35)
  (setq doom-modeline-bar-width 8)
  (setq doom-modeline-persp-name 'nil)
  (setq doom-modeline-buffer-file-name-style 'auto))

;; built-in sql
(setq sql-connection-alist
      '((fizdb16
	 (sql-product 'postgres)
	 (sql-port 8081)
	 (sql-server "localhost")
	 (sql-user "postgres")
	 (sql-database "fizdb2"))))

(after! sqlformat
  (setq sqlformat-command 'sql-formatter))

(map! :desc "Format sql buffer" :leader :n "df" #'sqlformat-buffer)

(defun clear-sql-buffer ()
  (goto-char (point-max))
  (comint-clear-buffer))

(defun eval-sql-buffer ()
  (interactive)
  (with-current-buffer sql-buffer (clear-sql-buffer))
  (sql-send-buffer))

(defun eval-sql-paragraph ()
  (interactive)
  (with-current-buffer sql-buffer (clear-sql-buffer))
  (sql-send-paragraph))

(defun eval-sql-line ()
  (interactive)
  (with-current-buffer sql-buffer (clear-sql-buffer))
  (sql-send-line-and-next))

(map! :desc "Eval sql buffer" :leader :n "dd" #'eval-sql-buffer)
(map! :desc "Eval sql paragraph" :leader :n "dp" #'eval-sql-paragraph)
(map! :desc "Eval sql line" :leader :n "dl" #'sql-send-line-and-next)
(map! :desc "Clear commit buffer" :leader :n "dc" #'comint-clear-buffer)
(map! :desc "Show sql table list" :leader :n "dt" #'sql-list-table)


(defun my/fix-ediff-size ()
  (with-selected-window (get-buffer-window "*Ediff Control Panel*")
    (setq window-size-fixed t)
    (window-resize (selected-window) (- 5 (window-total-height)) nil t)))

(add-hook 'ediff-after-setup-windows-hook 'my/fix-ediff-size)

;; ejc-mode
(after! ejc-sql
  (ejc-create-connection
   "fdb16"
   :classpath "[/home/nikita/.m2/repository/postgresql/postgresql/9.3-1102.jdbc41/postgresql-9.3-1102.jdbc41.jar]"
   :password "ine3ss62"
   :user "postgres"
   :port "8081"
   :host "localhost"
   :dbname "fizdb2"
   :dbtype "postgresql")
  )

(require 'ejc-company)
(add-hook! 'ejc-sql-minor-mode-hook
  (setq company-backends '(ejc-company-backend))
  (setq company-idle-delay 0.5))

(add-hook! 'ejc-sql-connected-hook
  (ejc-set-fetch-size nil)
  (ejc-set-max-rows nil)
  (ejc-set-show-too-many-rows-message t)
  (ejc-set-column-width-limit 30)
  (ejc-set-use-unicode nil)
  (setq ejc-result-table-impl 'ejc-result-mode)
  (setq ejc-complete-on-dot t))

(add-hook! 'ejc-sql-minor-mode-hook (ejc-eldoc-setup))
