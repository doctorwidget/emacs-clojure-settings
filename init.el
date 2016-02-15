(require 'package)


;; NB: these are two older repositories that seem to be NOT recommended!
;; (add-to-list 'package-archives             
;;                 '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;;                '("tromey" . "http://tromey.com/elpa/") t)

;; SNF added this archive manually
;; This is the official GNU archive.
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)


;; SNF added this archive manually
;; One 'stable' repository URL is melpa-stable.milkbox.net/packages/"
;; Another stable URL is http://stable.melpa.org/packages/"
;; and the unstable main repository is http://melpa.org/packages/
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))


;; SNF: After upgrading from v24.3 to v24.5, I found that when I launched
;; emacs.app emacs didn't know anything about my bash profile PATH, despite a
;; helper function copied from somewhere (which presumably used to fix it). I
;; still had access to my PATH when I launched emacs FROM a bash terminal, but
;; not when I launched it as emacs.app from the Finder.

;; The solution (other than just always launching from a terminal) was to
;; install (exec-path-from-shell) via the standard emacs (package-install).
;; Non-opaque docs can be found at the github project home:
;; https://github.com/purcell/exec-path-from-shell

;; The final step is to initialize that system. This must be called AFTER
;; calling (package-initialize), which we do up above.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; also note that ``M-x getenv PATH`` will echo out your actual available PATH
;; inside the current emacs instance. Very handy!


;; NOTE init.el calls to load user.el
;; So both are invoked, but init.el is in charge
(load "~/.emacs.d/user.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(fci-rule-color "#2a2a2a"))

;; SNF: removed call to custom-set-faces because it was overriding other theme values

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
