(require 'package)

(add-to-list 'package-archives '("org"          . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa"        . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; main packages
(use-package helm
  :ensure t
  :bind (("M-x"     . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x C-r" . helm-recentf)
         ("C-x C-b" . helm-buffers-list))
  )

(use-package evil
  :ensure t
  :config
  (evil-mode t)
  )

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  )

 ;; maybe remove later
(use-package general
  :ensure t
  :config
  (general-define-key
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
     "SPC" '(helm-M-x :which-key "M-x")
     ;; Bufers
     "b"   '(hydra-buffer/body :which-key "Buffer")
     ;; Files
     "f"   '(:ignore t :which-key "Files")
     "ff"  '(helm-find-files)
     "fr"  '(helm-recentf)
     )
  )

 ;; maybe remove later
(use-package hydra
  :ensure t
  :config
  (defhydra hydra-buffer (:color blue :columns 3)
    "
                  Buffers :
    "
    ("n" next-buffer "next" :color red)
    ("p" previous-buffer "prev" :color red)
    ("b" helm-buffers-list "list")
    ("N" evil-buffer-new "new")
    ("d" kill-this-buffer "delete" :color red)
    ("s" save-buffer "save" :color red))

)

;; minor configuration
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen  t)

(use-package linum
  :config
  (global-linum-mode 1))

(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
 )

;; specific languages
(use-package sml-mode
  :ensure t
  :config
  (setenv "PATH" (concat "/usr/lib/smlnj/bin:" (getenv "PATH")))
  (setq exec-path (cons "/usr/lib/smlnj/bin"  exec-path))
  )

(use-package julia-mode
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package racket-mode
  :ensure t)

(use-package magit
  :ensure t)


(use-package org
  :ensure t
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
)

(use-package ein
  :ensure t
  :config
  (defun start-jupyter ()
    "open jupyter with my parameters"
    (interactive)
    (ein:jupyter-server-start "/usr/bin/jupyter" "/home/kosh")
    ;;(ein:notebooklist-login)
    ;;(ein:notebooklist-open)
  )
)

;;(use-package ranger
;;  :ensure t
;;)

(use-package buffer-move
  :ensure t
)

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy))
)



;; something I have not added:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(package-selected-packages
   (quote
    (slime buffer-move ein haskell-mode general evil-leader which-key evil helm use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
