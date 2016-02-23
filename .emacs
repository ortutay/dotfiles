(add-to-list 'load-path "/Users/marcell/emacs/")
(add-to-list 'load-path "/Users/marcell/tern/emacs/")

(require 'web-mode)
(require 'jsx-mode)
(require 'rust-mode)

;; http://melpa.org/#/getting-started
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize) ;; You might already have this line

(ac-config-default)


;; React/JSX
;; (setq react-packages
;;     '(
;;       web-mode
;;       js2-mode
;;       tern-mode
;;       ))

;; (defun react/post-init-web-mode ()
;;   (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.react.js\\'" . web-mode))

;;   (add-hook 'web-mode-hook
;;             (lambda ()
;;               (when (or (equal web-mode-content-type "jsx")
;;                         (equal web-mode-content-type "javascript"))
;;                 (web-mode-set-content-type "jsx")
;;                 (add-to-list 'company-backends 'company-tern)
;;                 (js2-minor-mode)
;;                 (tern-mode))))

;;   (with-eval-after-load 'web-mode
;;     (defadvice web-mode-highlight-part (around tweak-jsx activate)
;;       (if (equal web-mode-content-type "jsx")
;;           (let ((web-mode-enable-part-face nil))
;;             ad-do-it)
;;         ad-do-it))))

;; end React/JSX


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

;; Python Hook
(add-hook 'python-mode-hook
          ((lambda ()
             (setq indent-tabs-mode nil
                   tab-width 2))))


;; ;; web mode
;; (require 'web-mode)
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (setq tab-width 2)
;;             (setq tab-stop-list (number-sequence 2 200 2))
;;             ))
;; ;; (add-to-list 'auto-mode-alist '("\\.ios.js\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode)) ;; for JSX
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jison\\'" . bison-mode))
;; (setq default-tab-width 2)
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



;; integrate with system copy/paste
;; source: http://stackoverflow.com/questions/3216081/integrate-emacs-copy-paste-with-system-copy-paste
;; (setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; http://stackoverflow.com/questions/14444935/unable-to-compile-emacs-auto-complete-dependency-on-popup
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (package-initialize)
;; (setq url-http-attempt-keepalives nil)

;; autocomplete
;; http://auto-complete.org/
;; (add-to-list 'load-path "~/.emacs.d")
;; (require 'auto-complete-config)
;; (ac-config-default)

;;02.02.2000
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
