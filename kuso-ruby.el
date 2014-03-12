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

;(add-hook 'ruby-mode-hook
;     	  'global-rbenv-mode)

;; Ruby mode configurations
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("config.ru$" . ruby-mode))

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
;; The default indentation system attempts to align the arguments of a function
;; with the opening bracket vertically.
;;
;; While this is subjective, but if you, like me, find this behaviour erratic
;; the following will make emacs indent code inside parenthesis similar to
;;  elsewhere.
(setq ruby-deep-indent-paren nil)
(add-hook 'ruby-mode-hook 'projectile-on)

;; Robe mode
(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'robe-ac-setup)

;; Bundler
(require 'bundler)

;; Flymake
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)


(add-hook 'ruby-mode-hook (lambda () (autopair-global-mode -1)))

;; Power Line
(require 'powerline)

;; highlight indents
(require 'highlight-indentation)
;; TODO: move these to a theme
(set-face-background 'highlight-indentation-face "#383a30")
(set-face-background 'highlight-indentation-current-column-face "#494d38")
(add-hook 'ruby-mode-hook 'highlight-indentation-mode)

(setq powerline-arrow-shape 'arrow)   ;; the default
(setq powerline-arrow-shape 'curve)   ;; give your mode-line curves
(setq powerline-arrow-shape 'arrow14) ;; best for small fonts
(custom-set-faces
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))
(setq powerline-color1 "grey22")
(setq powerline-color2 "grey40")

(require 'es-lib)
(require 'es-windows)
