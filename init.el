(require 'package)
(add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
              '("tromey" . "http://tromey.com/elpa/") t)

;; SNF added this archive manually
;; Updated URL on 2015-05-25 (was melpa-stable.milkbox.net/packages/"
;; Other stable URL is http://stable.melpa.org/packages/"
;; but the main URL below seems pretty stable to me!
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; NOTE init.el calls to load user.el
;; So both are invoked, but init.el is in charge
(load "~/.emacs.d/user.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "fd7ef8af44dd5f240e4e65b8a4eecbc37a07c7896d729a75ba036a59f82cfa58" "52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "e93c4567f5d30365064747972b179e80939cee875627034dc76cd50477c6b998" "ebc7e94f697502eb2828c5ceb00ae073f05492d5a62c542d4acd2de4e3edba72" "2ada32764f5bba7a7d1779fb291361d1360827c28b96b3fcd5f53e05f32be0ed" "342e86760238905d408a499b9935666d854414a5f7d75b4649088093584bb3cb" "c0dd134ecd6ede6508c30f7d4ac92334229531df62284fc6572f65b4d0cde43f" "4af74caa483a62bd952f092e58fe41f7c953a200a9eba61d5e495701e450a7e1" "f22a0f5b85aed98055e4e5013cc104829d163067c03f8165ab03ae010d6e3d40" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "9e54a6ac0051987b4296e9276eecc5dfb67fdcd620191ee553f40a9b6d943e78" default)))
 '(fci-rule-color "#2a2a2a"))

 
;; SNF: removed call to custom-set-faces because it was overriding other theme values

;; NB: the ``#-``  and ``#+`` reader macros lets you comment out one entire
;; SEXPs in one fell swoop, which is very handy due to paredits fussiness.
;; This is similar to what you get with Clojure's ``#_`` reader macro. 
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#000000" :foreground "#eaeaea" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Monaco")))))
;; SNF: removed this call to custom-set-faces, because it was making it
;; impossible to load or  use other themes.

;; see snf_emacs_configuration.rst for some notes regarding configuration in
;; general, and themes in particular. 

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
