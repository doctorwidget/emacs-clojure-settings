;; This file is launched by init.el partway through.
;; Think of init.el as the location for the highest-order customizations.
;; More trivial stuff like theming lives here. 

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it

(setq initial-frame-alist '((top . 0) (left . 0) (width . 177) (height . 53)))

(defun my-standard-layout ()
  "Set up a 2-column, 3-window layout"
  (split-window-horizontally)
  (next-multiframe-window) ; NB: (other-window) fails only when used on startup
  (split-window-vertically))

(my-standard-layout)

;; set up a standard 2-column, 3-window layout on every startup
;(split-window-horizontally)  ; C-x-3
;(sit-for 1)
;(other-window) 
;(split-window-vertically)  ; C-x-2
;(balance-windows)          ; C-x-+  (only necessary if you want 3 columns)


;; Place downloaded elisp files in this directory. You'll then be able to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
;; Uncomment this to increase font size
(set-face-attribute 'default nil :height 140)

;; themes galore!
;;(load-theme 'adwaita t)
;;(load-theme 'wombat t)
;;(load-theme 'soft-stone t)
;;(load-theme 'tomorrow-night-bright t)
(load-theme 'solarized-dark t)
;;(load-theme 'solarized-light t)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

(load "~/.emacs.d/vendor/clojure")

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list
      (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list
      (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

(setq ido-use-filename-at-point nil)

;; Save here instead of littering current directory with emacs backup files
(setq backup-directory-alist `(("." . "~/.saves")))

;; SNF: turn on column numbers in all modes, including rST, etc
(setq-default column-number-mode t)

;; SNF: use 80 chars as the limit by default
(setq-default fill-column 80)

;; SNF: use 4 spaces for tabs
(setq-default tab-width 4)

;; SNF: turning on rainbow-delimiters-mode wasn't as easy as I expected
;; (rainbow-delimiters-mode) ;;this works in the minibuffer, but not here!
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)  ;; this works here.


;; SNF turn speedbar on by default added this manually
;; (setq speedbar-use-images nil)
;; (setq speedbar-show-unknown-files t)
;; (when window-system   ;start speedbar iff in a windowed environment
;;   (speedbar t))


;; SNF added 2015_06_07 to enable ansi color inside the shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)


;; SNF added 2014_12_20 to enable syntax coloring for robot framework files
(load-file "~/.emacs.d/vendor/robot-mode.el")
(add-to-list 'auto-mode-alist '("\\.robot\\'" . robot-mode))


;; SNF time mode fu added 2015_06_06
;; see http://www.emacswiki.org/emacs/DisplayTime
(display-time-mode 1)


;; SNF org mode configuration 2015_06_08. Org mode is standard with emacs 22+
;; **but** comes with surprisingly few keys bound. Yet tutorials everywhere
;; suggest the same set of keys for use, as if they were preconfigured. I feel
;; like I must be missing some easy global default setting, or maybe these keys
;; were lost in the shuffle during the transition from orgmode being an optional
;; package to a standard one.
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda) ;; triggers followup
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-c." 'org-time-stamp)
(define-key global-map "\C-c!" 'org-time-stamp-inactive)
(define-key global-map "\C-c/" 'org-sparse-tree) ; triggers followup
(setq org-log-done t)

(setq org-log-done 'time)  ;; auto-timestamps on DONE
;(setq org-log-done 'note) ;; forces you to write closing notes for each DONE!
(setq org-todo-keywords
         `((sequence "TODO(t)" "HOLD(h)" "WAIT(w)" "|" "DONE(d)")))

(setq org-agenda-files
      (list "~/org/fitzbits.org"
            "~/org/folk.org"
            "~/org/health.org"
            "~/org/hobby.org"
            "~/org/home.org"
            "~/org/misc.org"
            "~/org/pasadero.org"
            "~/org/skills.org"))

;; zomg if you don't do this, all agenda commands (C-c a *) will completely
;; destroy your window setup, replacing all of your carefully-laid-out buffers
;; with two ginormous panels, one above the other, and one of which isn't even
;; used! Your original setup is NOT restored when you kill either of those
;; buffers!other setup, regardless of how you started out. WTF.
(setq org-agenda-window-setup 'current-window)
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-sticky nil) ;; for when agenda buffer is hidden, not killed

;; scheduling and deadline-related values
(setq org-deadline-warning-days 3) ;; 3 day warning on deadlines

;; prevent scheduled items from showing up as items on the global todo list
;; NB: they will still show up on the global *agenda*, just not the *todo*
(setq org-agenda-todo-ignore-scheduled 'future)
(setq org-agenda-tags-todo-honor-ignore-options t)



;; add this to your .bash_profile to ensure that the latest emacs.app is
;; used, in lieu of the (ancient) version that OSX defaults to. 
;; alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"

;; SNF 2015_12_09  I thought these used to be standard paredit mode?
;; Also note: ``C-h k (key)`` makes emacs tell you the code for any key
;; And (kbd) converts & sanitizes multiletter stuff like S-<right> 
;; Finally, (define-key global-map) and (global-set-key) are synonyms?
(global-set-key (kbd "S-<right>") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "S-<left>") 'paredit-forward-barf-sexp)

;; SNF 2016-02-22  various elpy-mode things
(elpy-enable)


