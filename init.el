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

;; SNF added this archive manually just for the ``elpy`` package
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

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

;; NB: ~/.emacs.d/init.el is part of the standard emacs startup process. In
;; contrast, there's absolutely nothing standard about user.el. However, some
;; functions (like Custom, below) automatically edit ``init.el``, which makes me
;; a tiny bit nervous. So I only do the most fundamental stuff here, like
;; managing packages and the OSX path workaround above, and reserve all of my
;; other custom code for user.el. Inside user.el, I know I'm to blame for all
;; the code!
(load "~/.emacs.d/user.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(custom-safe-themes
   (quote
    ("52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "9e54a6ac0051987b4296e9276eecc5dfb67fdcd620191ee553f40a9b6d943e78" "8b51a9d5604680d5d533c9cae132f68bca1e02563b2b0943ff9d45eb9043605a" "ebc7e94f697502eb2828c5ceb00ae073f05492d5a62c542d4acd2de4e3edba72" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "e93c4567f5d30365064747972b179e80939cee875627034dc76cd50477c6b998" default)))
 '(fci-rule-color "#2a2a2a")
 '(pyvenv-mode t)
 '(safe-local-variable-values
   (quote
    ((pyvenv-activate quote /Users/scottfitz/code/py/book/lightweight/lightvenv)
     (elpy-project-root . ~/code/py/book/lightweight)
     (elpy-project-ignored-directories . gedcom)
     (elpy-project-root . ~/code/py/gedomatic)
     (pyvenv-workon . gedomatic)
     (pyvenv-workon . snf)
     (elpy-test-runner . elpy-test-pytest-runner)
     (elpy-project-root . ~/code/py/snf/)
     (whitespace-line-column . 80)
     (lexical-binding . t)))))

;; SNF: removed call to custom-set-faces because it was overriding other theme values
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; SNF: added for web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.dtl$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tm?pl$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.j2$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))

;; SNF per the docs, you need to add specific engine associations!
(setq web-mode-engines-alist
      '(("django" . "\\.html?$")))
