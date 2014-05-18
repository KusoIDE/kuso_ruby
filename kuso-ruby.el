;;   Kuso IDE
;;    Copyright (C) 2010-2013  Sameer Rahmani <lxsameer@gnu.org>
;;
;;    This program is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation, either version 3 of the License, or
;;    any later version.
;;
;;    This program is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.
;;
;;    You should have received a copy of the GNU General Public License
;;    along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Configuring rbenv
(require 'rbenv)
(global-rbenv-mode)


;; Utilities ------------------------------------------------
;;;###autoload
(defun insert-arrow ()
  (interactive)
  (delete-horizontal-space t)
  (insert " => "))

;; Ruby mode configurations --------------------------------
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("config.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("json.jbuilder$" . ruby-mode))

;; Yaml mode configurations
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; Inf Ruby configuration
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'rbenv-patch)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(defun rbenv-patch ()
  (setq irbparams " --inf-ruby-mode -r irb/completion")
  (setq irbpath (rbenv--expand-path "shims" "irb"))
  (setq irb (concat irbpath irbparams))
  (add-to-list 'inf-ruby-implementations (cons "ruby" irb))
  ;(inf-ruby-minor-mode t)
  )

(global-set-key (kbd "C-c r r") 'inf-ruby)
(add-hook 'ruby-mode-hook 'projectile-on)

;; Robe mode
;(require 'robe)
;(add-hook 'ruby-mode-hook 'robe-mode)
;(add-hook 'robe-mode-hook 'robe-ac-setup)
;; Bundler
(require 'bundler)


(add-hook 'ruby-mode-hook (lambda ()
                            ;; Disable autopaire
                            (autopair-global-mode -1)
                            (autopair-mode -1)
                            (require 'inf-ruby)
                            (ruby-tools-mode t)
                            (ruby-electric-mode t)
                            ;; Enable flycheck
                            (flycheck-mode t)

                            ;; hs mode
                            (hs-minor-mode t)
                            ;; Hack autocomplete so it treat :symbole and symbole the same way
                            (modify-syntax-entry ?: ".")
                            ))

(define-key ruby-mode-map (kbd "C-.") 'insert-arrow)

;; configure hs-minor-mode
(add-to-list 'hs-special-modes-alist
             '(ruby-mode
               "\\(class\\|def\\|do\\|if\\)" "\\(end\\)" "#"
               (lambda (arg) (ruby-end-of-block)) nil))
