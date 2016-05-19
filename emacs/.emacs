(add-to-list 'load-path "/Users/marcell/emacs/")

(require 'web-mode)
(require 'jsx-mode)
(require 'rust-mode)
(require 'jade-mode)
(require 'stylus-mode)
(require 'php-mode)

;; https://www.emacswiki.org/emacs/EmacsApp
(if (not (getenv "TERM_PROGRAM"))
    (let ((path (shell-command-to-string
                 "$SHELL -cl \"printf %s \\\"\\\$PATH\\\"\"")))
      (setenv "PATH" path)))
(setq exec-path (split-string (getenv "PATH") ":"))

;; https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(defalias 'qrr 'query-replace-regexp)
(defalias 'rr 'query-replace-regexp)

;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Frame-Parameters.html
(add-to-list 'default-frame-alist '(foreground-color . "#ddd"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(cursor-color . "coral"))
(add-to-list 'default-frame-alist '(alpha . 85))

;; http://stackoverflow.com/questions/10147686/how-to-automatically-navigate-to-default-found-tag
(defun sm-find-tag ()
  (interactive)
  (find-tag (funcall (or find-tag-default-function
                         (get major-mode 'find-tag-default-function)
                         'find-tag-default))))

;; http://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; ;; http://stackoverflow.com/questions/24833964/package-listed-in-melpa-but-not-found-in-package-install
;; (cond
;;  ((>= 24 emacs-major-version)
;;   (package-refresh-contents)
;;  )
;; )
(package-initialize)

(ac-config-default)

(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-/") 'comment-region)
(global-set-key (kbd "M-i") 'indent-to-column)
(global-set-key (kbd "C-/") 'undo)
(global-set-key (kbd "M-?") 'uncomment-region)

;; scrollers
(global-set-key "\M-n" "\C-u4\C-v")
(global-set-key "\M-p" "\C-u4\M-v")

;; Two spaces for indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-stop-list (number-sequence 2 200 2))
(with-eval-after-load 'web-mode
    (push '("lineup-calls" . nil) web-mode-indentation-params))
(setq-default
   ;; js2-mode
   js2-basic-offset 2

   ;; web-mode
   css-indent-offset 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2)

;; go mode
(require 'go-mode-autoloads)
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            ))

(add-hook 'go-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'godef-jump)))

;; ;; Python Hook
;; (add-hook 'python-mode-hook
;;           ((lambda ()
;;              (setq indent-tabs-mode nil
;;                    tab-width 2))))


(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode)) ;; for JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jison\\'" . bison-mode))
(setq js-indent-level 2)
(setq jsx-indent-level 2)

(setq web-mode-markup-indent-offset 2)

;; JSX
(add-hook 'web-mode-hook
          (lambda ()
            (when (or (equal web-mode-content-type "jsx")
                      (equal web-mode-content-type "javascript"))
              (web-mode-set-content-type "jsx")
              ;; (add-to-list 'company-backends 'company-tern)
              (js2-minor-mode)
              ;; (tern-mode)
              )))

(add-hook 'web-mode-hook
          (lambda () (setq comment-start "//"
                           comment-end "")))


;; 02.02.2000
(defun xsteve-remove-control-M ()
  "Remove ^M at end of line in the whole buffer."
  (interactive)
  (save-match-data
    (save-excursion
      (let ((remove-count 0))
        (goto-char (point-min))
        (while (re-search-forward (concat (char-to-string 13) "$") (point-max) t)
          (setq remove-count (+ remove-count 1))
          (replace-match "" nil nil))
        (message (format "%d ^M removed from buffer." remove-count))))))

(setq ruby-insert-encoding-magic-comment nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
