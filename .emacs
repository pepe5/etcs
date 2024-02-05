
;; -*- mode: emacs-lisp -*-
;; +ěščř+
;; >! pcs require/s

;; Cont. w/> https://melpa.org/#/getting-started
(require 'package)
;; (setq package-enable-at-startup nil) ;; https://emacs.stackexchange.com/questions/53105/getting-error-failed-to-download-gnu-archive-on-emacs-26-3
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t) ; >? https
(setq package-archives '(("melpa" . "https://melpa.org/packages/"))) ; ok, on rh8.4, 2021-9
;; Added by Package.el.
(package-initialize)
;; package-refresh-contents not working :(
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(require 'facemenu)

(set-language-environment "utf-8")

;; https://emacs.stackexchange.com/questions/18533/how-to-use-the-insert-key-to-toggle-overwrite-mode-when-using-a-pc-keyboard-in
(global-set-key [help] #'overwrite-mode)
(global-set-key [f2] 		'toggle-truncate-lines)
(global-set-key (kbd "s-w") 'toggle-truncate-lines)
(global-set-key (kbd "s-b") 'backward-word)
(global-set-key (kbd "s-f") 'forward-word)
(global-set-key (kbd "s-t") 'transpose-words)

(defun my-shell () "" (interactive) (shell (buffer-name)))
(global-set-key [f5] 		'my-shell)
(global-set-key (kbd "s-5") 'my-shell)
(defun i2-interactive-off () (interactive)
  (remove-hook 'comint-output-filter-functions
	       'comint-watch-for-password-prompt)
  (message "watch-for-password-prompt filter remove/d..") )

(defun my-toggle-trailing-whitespace ()
  "hmm - inspired by gnus-sum.el '(defun gnus-summary-toggle-truncation*)"
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace))
  (redraw-display))
(global-set-key [f6] 'my-toggle-trailing-whitespace)

(defun my-toggle-ro () "" (interactive) (save-buffer) (toggle-read-only))
(global-set-key [f7] 		'my-toggle-ro)
(global-set-key (kbd "s-7") 'my-toggle-ro)
(global-set-key (kbd "s->")   'end-of-buffer)
(global-set-key (kbd "C-s-.") 'end-of-buffer)
(global-set-key (kbd "C-s-,") 'beginning-of-buffer)
(global-set-key (kbd "C-s-;") 'eval-expression)
(global-set-key (kbd "C-s-9") 'insert-parentheses)

(fset 'p3-pack1-line "\C-a\C-p\223\C-r\C-q\C-j[ \C-i]*\C-q\C-j\C-m\C-k\C-a\C-n")
(global-set-key [f9] 		'p3-pack1-line)
(global-set-key (kbd "s-9") 'p3-pack1-line)

(fset 'c1-next-cmd ; get next command-line from other window
      [?\C-a ?\C-k ?\C-\M-o ?\C-s ?> ?\S-  ?\C-m ?\C-  ?\C-e ?\M-w ?\C-\M-o ?\C-y])
(global-set-key (kbd "<f12>") 'c1-next-cmd)

(fset 'split-h "\C-x2")
(global-set-key (kbd "<S-f2>") 'split-h)
(global-set-key (kbd  "s-2")   'split-h)
(global-set-key (kbd  "s-p")   'previous-line)
(global-set-key (kbd  "s-o")   'delete-window)

(fset 'split-v "\C-x3")
(global-set-key (kbd "M-s-8")  'call-last-kbd-macro)
(global-set-key (kbd "M-s-3")  'start-kbd-macro)
(global-set-key (kbd "<S-f3>") 'split-v)
(global-set-key (kbd  "s-3")   'split-v)
(global-set-key (kbd  "s-1")   'delete-other-windows)

(defun hlt-region () "" (interactive) (hlt-highlight-region))
(global-set-key (kbd "<C-f5>") 'revert-buffer)
(global-set-key (kbd "M-s-5")  'revert-buffer)
(global-set-key (kbd "<C-f9>") 'hlt-region)
(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-s-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-s-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-o") 'other-window)
(global-set-key (kbd "C-s-o") 'other-window)
(global-set-key (kbd "C-c o") 'find-file-at-point)

(fset 'r1-rectangle-to-1line [?\M-> ?\C-o ?\M-> ?\C-x ?r ?y ?\C-x ?\C-x ?\M-% ?\C-o return ?  return ?! ?\C-a ?\C-k ?\C-/])
(global-set-key (kbd "C-M-<return>") 'r1-rectangle-to-1line)

(defun transpose-windows () ; /swap-frames/
  "//paste.lisp.org/display/73195 from //paste.lisp.org/display/14341"
  (interactive)
  (let* ((W1 (selected-window))
         (W2 (other-window 1))
         (B1 (window-buffer  W1))
         (B2 (window-buffer  W2)))
    (set-window-buffer W1 B2)
    (set-window-buffer W2 B1))
  (other-window 1))
(global-set-key (kbd "C-x 4 t") 'transpose-windows)
(global-set-key (kbd "C-M-j") 'transpose-windows)
(global-set-key (kbd "C-s-j") 'transpose-windows)

(global-set-key (kbd "C-x c") 'server-edit)
(global-set-key (kbd "C-x C-k") 'kill-buffer)
(global-set-key (read-kbd-macro "C-x c") 'server-edit)

(defun i1-ibuffer-hlt () "" (interactive) (progn (ibuffer) (hlt-region)))
(global-set-key (kbd "C-x C-b") 'i1-ibuffer-hlt)
(define-prefix-command 'mm-map)
(global-set-key (kbd "M-m")     'mm-map)
(global-set-key (kbd "M-m M-m") 'back-to-indentation)
(global-set-key (kbd "s-/")		'dabbrev-expand)
(global-set-key (kbd "<M-tab>") 'next-multiframe-window) ; toggle-frame-maximized)
(global-set-key (kbd "M-s-a") 	'toggle-frame-maximized)
(global-set-key (kbd "M-a") 	'backward-sentence)
(global-set-key (kbd "s-a") 	'backward-sentence)
(global-set-key (kbd "s-d") 	'kill-word)
(global-set-key (kbd "s-i") 	'overwrite-mode)
(global-set-key (kbd "s-<backspace>") 'backward-kill-word)

(setq frame-title-format '("%* " "%b" ": " "%p" " emacs%@ @ " (:eval (system-name))))
(setq old-line-format mode-line-format) ; (setq old-default-format default-mode-line-format)
(setq-default mode-line-format nil)
(setq-default auto-hscroll-mode 'current-line)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;;; dired macro/s
(defun use-monospace ()
  "Switch the current buffer to a monospace font."
  (face-remap-add-relative 'default '(:family "Monospace")))
(add-hook 'dired-mode-hook 'use-monospace)


;; ibuffer macro/s
(add-hook 'ibuffer-mode-hook
          '(lambda () (define-key ibuffer-mode-map "g" 'i1-ibuffer-hlt) ))


;;; shell macro/s
(defun my-comint-init () (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'my-comint-init)

(setq cat-string " | nl | tail") ; -${T}0 ; cat -n | tr \\\\t \\ | 
(make-variable-buffer-local 'cat-string)
(fset 'cn-insert-cat-tail " | nl | tail") ; grep .
(fset 'cn-insert-cat-tac " | nl | tail | tac | xargs echo")

(fset 'c1-int [?\M-> ?\C-q ?\C-c return]) ; ^c
(fset 'd1-eof [?\M-> ?\C-q ?\C-d return]) ; ^d
(fset 'c2-prompt [?\C-c ?\C-p ?\C-r ?> ?\S-  ?\C-m ?\C-a ?\C-  ?\M-> ?\C-p ?\C-w ?\C-d ?\C-e]) ; clean last i/o
(fset 'cc-prompt [f7 f1 ?\C-c ?\C-p ?\C-r ?> ?\S-  ?\C-m ?\C-a ?\C-  ?\M-> ?\C-p ?\C-w ?\C-d ?\C-e]) ; clean last i/o
(fset 'z1-my-cat-toggle [?c ?a ?t ?  ?- ?n return])
(fset 'f11-poly-reset-prompt [?: ?r ?e ?s ?e ?t ?_ ?p ?r ?o ?m ?p ?t return])
(fset 'z1-ssh-suspend [?~ ?\C-q ?\C-z return]) ; ^z << ?\C-q ?\C-g return 
(fset 'z1-my-suspend-fg-toggle [?\C-a ?\C-k ?~ ?\C-q ?\C-z return f9 ?\C-e ?\C-o ?\M-> ?f ?g ?  ?% ?- return]) ; >? ?\C-q ?\C-c return

(defun d2-toggle-to-unix () "" (interactive)
       (set-buffer-process-coding-system 'utf-8-unix 'utf-8-dos))
(defun d3-toggle-to-unix () "" (interactive)
       (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))

(defun c3-comint-show-whole-window () "" (interactive) (recenter -3))
(defun c2-my-comint-show-output ()
  "Display start of this batch of interpreter output. Sets mark to the value of point when this command is run."
  (interactive)
  (push-mark)
  (let ((pos (or (marker-position comint-last-input-end) (point-max))))
    (cond (comint-use-prompt-regexp
	   (goto-char pos)
	   (beginning-of-line 0)
	   (comint-skip-prompt))
	  (t
	   (goto-char (field-beginning pos))))))

(define-minor-mode saved-mode
  "save continuously"
  :lighter " saved"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c f") 'c3-comint-show-whole-window)
            map))

;; TODO replacement of z1-my-suspend-fg-toggle
(fset 't1-toggle-sshs
   [S-f8 f9 ?\C-e ?\C-o ?\M-> ?f ?g ?  ?- return ?\C-p ?\C-e ?\C-o ?\M->])
;; (global-set-key (kbd "C-C -") 't1-toggle-sshs)

(add-hook 'shell-mode-hook
          '(lambda ()
             (define-key shell-mode-map (kbd "<f1>") 'c1-int)
             (define-key shell-mode-map (kbd "ESC C") 'c1-int)

             (define-key shell-mode-map (kbd "<f8>") 'call-last-kbd-macro)
             (define-key shell-mode-map (kbd "S-<f9>") 'cc-prompt)
             (define-key shell-mode-map (kbd "S-<f11>") 'f11-poly-reset-prompt)
             (define-key shell-mode-map (kbd "S-<f7>") 'z1-my-cat-toggle)
             (define-key shell-mode-map (kbd "S-<f1>") 'c2-prompt)
             (define-key shell-mode-map (kbd "S-<f8>") 'z1-ssh-suspend)
             (define-key shell-mode-map (kbd "s-8")    'z1-ssh-suspend)
             (define-key shell-mode-map (kbd "s-r") 'comint-history-isearch-backward-regexp)
             (define-key shell-mode-map (kbd "s-p") 'comint-previous-input)
             (define-key shell-mode-map (kbd "s-n") 'comint-next-input)
             (define-key shell-mode-map (kbd "C-d") 'delete-char)
             (define-key shell-mode-map (kbd "C-c C-o") 'org-open-at-point)
             (define-key shell-mode-map (kbd "C-c -") 'z1-my-suspend-fg-toggle)
             (define-key shell-mode-map (kbd "C-c C--") 't1-toggle-sshs)

             (define-key shell-mode-map (kbd "M-z") (lambda () (interactive) (insert cat-string)))
             (define-key shell-mode-map (kbd "M-C-c") 'cn-insert-cat-tac) ; z3-my-suspend-only?

             (define-key shell-mode-map (kbd "M-<f8>") 'd2-toggle-to-dos)
             (define-key shell-mode-map (kbd "M-<f9>") 'd3-toggle-to-unix) ; d4-clean-timeout
             (define-key shell-mode-map (kbd "M-<")   'c3-comint-show-whole-window)
             (define-key shell-mode-map (kbd "C-s-,") 'c3-comint-show-whole-window)
             (define-key shell-mode-map (kbd "M-C-,") 'beginning-of-buffer)
             (define-key shell-mode-map (kbd "M-C-l") 'c2-my-comint-show-output) ; is this the default?
             (define-key shell-mode-map (kbd "C-s-l") 'c2-my-comint-show-output)
             ))

;; old good style city-lights
(defun g4-my-green () ""
       (interactive)
       (set-background-color "black")
       (set-foreground-color "green4")
       (set-cursor-color "yellow")
       (set-mouse-color "blue")
       (global-font-lock-mode t)
       (set-face-attribute 'fringe nil :foreground "blue" :background "gray17")
       (setq term-current-row -1)
       )
(defun g1-my-green () ""
       (interactive)
       (set-background-color "black")
       (set-foreground-color "green")
       (set-cursor-color "yellow")
       (set-mouse-color "blue")
       (global-font-lock-mode t)
       (set-face-attribute 'fringe nil :foreground "blue" :background "gray17")
       (setq term-current-row -1)
       )
(g1-my-green)

(defun l1-my-LightYellow4 () ""
       (interactive)
       (set-background-color "black")
       (set-foreground-color "LightYellow4")
       (set-cursor-color "yellow")
       (set-mouse-color "blue")
       (global-font-lock-mode t)
       (setq term-current-row -1)
       )

(defun m1-my-magenta () ""
       (interactive)
       (set-foreground-color "magenta")
       (set-background-color "white")
       (set-cursor-color "blue")
       )

(defun b1-my-blue () ""
       (interactive)
       (set-background-color "white") ; wheat1
       (set-foreground-color "black")
       (set-cursor-color "yellow4")
       (set-mouse-color "blue")
       (global-font-lock-mode t)
       (set-face-attribute 'fringe nil :background nil)
       (setq term-current-row -1)
       )


(if (fboundp 'w32-version)
    ;; try>! https://github.com/pepe5/emacs-ipython-notebook
    (progn
      (setq
       python-shell-interpreter "C:\\Programs+\\Python-27\\python.exe"
       python-shell-interpreter-args "-i C:\\Programs+\\Python-27\\Scripts\\ipython-script.py"
       python-shell-prompt-regexp "In \\[[0-9]+\\]: \\|>>> "
       python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
       python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
       python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
       python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
       )
      (set-face-attribute 'default nil :font "Arial Narrow-14:antialias=none"); http://stackoverflow.com/questions/1279906/turn-off-anti-alias-for-font-in-emacs-23
      ) )

(defun h1-hilight-prompts ()
  "TIP: it is possible to add colors by -mode AFTER hi-lighting!"
  (interactive)
  ;; (require 'highlight)

  (hi-lock-face-phrase-buffer "\[[$.A-Z_a-z]+[@:].+\].*" 'hi-blue-b)
  (hi-lock-face-phrase-buffer "^[a-z]+ ([/0-9]+)>" 'hi-blue-b)
  (hi-lock-face-phrase-buffer "^[^ ]+[]>] .*\\|[Ee]rror\\|[Ff]ail\\|ERR\\|FAIL" 'hi-red-b)
  (hi-lock-face-phrase-buffer "[a-zA-Z]+# .*" 'hi-red-b)
  (hi-lock-face-phrase-buffer "[1-9][0-9]*%" 'hi-red-b)
  (hi-lock-face-phrase-buffer ".*>\$ .*" 'font-lock-warning-face)
  (hi-lock-face-phrase-buffer "!.*\\| #.*\\|:#.*\\|^ok .*" 'font-lock-comment-face)
  (hi-lock-face-phrase-buffer "reboot.*" 'font-lock-comment-face)
  (hi-lock-face-phrase-buffer "\^M\\|\^\[\\[0K" 'org-hide) ; escape-glyph
  (hi-lock-face-phrase-buffer "�" 'org-hide)
  (hi-lock-face-phrase-buffer "pep> .*" 'font-lock-doc-face) ; good for sts tail-f
  (hi-lock-face-phrase-buffer "==> .*" 'link-visited)
  (hi-lock-face-phrase-buffer "\\[[0-z][0-z]" 'org-hide) ; hide screen exposures

  ;; (hi-lock-face-phrase-buffer "\[.*\]" 'info-node)
  ;;>! (hi-lock-face-phrase-buffer ":[ ]+.*" 'font-lock-function-name-face)
  ;; (hi-lock-face-phrase-buffer "^\./.*.log" 'hi-yellow)
  )
;; You can use selective/regioned Mono font even in shell (font-lock/ed) buffer by hlt-highlight-region (highlight.el)
;; (and then> hlt-replace-highlight-face "highlight" "variable-pitch")

(defun h8-hilight-screen-controls ()
  "" (interactive)
  (hi-lock-face-phrase-buffer "\^X\\|\^Y" 'org-hide)
  (hi-lock-face-phrase-buffer "==> .*" 'link-visited)
  (hi-lock-face-phrase-buffer "\\[[0-z][0-z]\\(32m\\)?" 'org-hide)
  (hi-lock-face-phrase-buffer "[-0-9A-z']+ *[=]" 'font-lock-variable-name-face)
  (hi-lock-face-phrase-buffer "[-0-9A-z]+['\"][:]" 'font-lock-variable-name-face)
  (hi-lock-face-phrase-buffer "\\[[0-z][0-z]?C\\|\\]2;" 'file-name-shadow)
  (hi-lock-face-phrase-buffer "\\$\\|%" 'font-lock-constant-face)
  (hi-lock-face-phrase-buffer ">>>" 'hi-red-b)
  )

(defun h9-hilight-screen-controls ()
  "" (interactive)
  (hi-lock-face-phrase-buffer "\^X\\|\^Y" 'org-hide)
  (hi-lock-face-phrase-buffer "==> .*" 'link-visited)
  (hi-lock-face-phrase-buffer "\\[[0-z][0-z]\\(32m\\)?" 'org-hide)
  (hi-lock-face-phrase-buffer "[0-9A-z\"]+ ?[:=]" 'font-lock-variable-name-face)
  (hi-lock-face-phrase-buffer "\\[[0-z][0-z]?C\\|\\]2;" 'file-name-shadow)
  (hi-lock-face-phrase-buffer "\\$" 'font-lock-constant-face)
  (hi-lock-face-phrase-buffer ">>>" 'hi-red-b)
  )

(defun h2-hilight-results () ""
  (interactive)
  ;; >! add moccur "test result\|_pep_\|pep>\|\[ [a-z] \]"!
  (hi-lock-face-phrase-buffer ".* \\[ ERROR \\]" 'speedbar-selected-face) ; widget-button-pressed-face (| cscope-line-number-face ?) ;<-| sh-* need 1st loaded shell-script[bash] mode
  (hi-lock-face-phrase-buffer "\\[ ERROR \\]\\|TODO\\|FAIL\\|Error\\|error\\|ERR\\|fail" 'hi-red-b)
  (hi-lock-face-phrase-buffer ".* \\[ ERROR - known bug \\]" 'file-name-shadow)
  (hi-lock-face-phrase-buffer "\\[ ERROR - known bug \\]" 'escape-glyph) ; file-name-shadow
  (hi-lock-face-phrase-buffer ".* \\[ SKIPPED \\]\\|SKIP" 'font-lock-variable-name-face)
  (hi-lock-face-phrase-buffer "PASS" 'compilation-mode-line-exit)
  (hi-lock-face-phrase-buffer "Description: .*\\|Desc: .*" 'font-lock-comment-face)
  (hi-lock-face-phrase-buffer "\\[ SKIPPED \\]\\|WARN" 'sh-heredoc)
  (hi-lock-face-phrase-buffer "Test result of" 'font-lock-doc-face) ;>! custom-group-tag
  (hi-lock-face-phrase-buffer "Name: .*" 'search-buffers-header-face)
  ;; in some situations can help: (hi-lock-set-pattern "proc AS[_0-9A-Za-z]+" 'hi-red-b)
  ;; (toggle-read-only 0)
  ;; (flush-lines "\\[ BEGIN \\]")
  )

(setq djcb-read-only-color       "brown")
(setq djcb-read-only-cursor-type 'hbar)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "lightblue")
(setq djcb-normal-cursor-type    'bar)

(defun djcb-set-cursor-according-to-mode ()
  "//emacs-fu.blogspot.com/2009/12/changing-cursor-color-and-shape.html"
  (cond
    (buffer-read-only
      (set-cursor-color djcb-read-only-color)
      (setq cursor-type djcb-read-only-cursor-type))
    (overwrite-mode
      (set-cursor-color djcb-overwrite-color)
      (setq cursor-type djcb-overwrite-cursor-type))
    (t 
      (set-cursor-color djcb-normal-color)
      (setq cursor-type djcb-normal-cursor-type))))
(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(deeper-blue))
 '(delete-by-moving-to-trash t)
 '(dired-listing-switches "-gGlhF --time-style=long-iso -I*~ -t")
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(ein:output-area-inlined-images t)
 '(eshell-prompt-function (lambda nil (concat "kraljo:S" ":$> ")))
 '(eshell-prompt-regexp "^[^#$
]*:[#$]> ")
 '(global-highlight-parentheses-mode t)
 '(highlight-indent-guides-method 'fill)
 '(highlight-indent-guides-responsive 'stack)
 '(indent-tabs-mode nil)
 '(ispell-dictionary nil)
 '(magit-status-margin '(nil "%Y-%m-%d %H:%M " magit-log-margin-width nil 18))
 '(menu-bar-mode nil)
 '(mini-modeline-face-attr nil)
 '(package-selected-packages
   '(kubernetes-tramp realgud realgud-ipdb realgud-trepan-ni vlf browse-at-remote magit magit-circleci magit-gh-pulls magit-org-todos magithub docker-tramp ein markdown-mode ham-mode jekyll-modes leanote flymd))
 '(safe-local-variable-values '((encoding . utf-8)))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tramp-copy-size-limit 999240)
 '(tramp-default-method "ssh")
 '(warning-suppress-log-types '((auto-save) (comp)))
 '(warning-suppress-types '((comp))))

;; pep> 
;; -DAMA-Ubuntu Condensed-normal-normal-normal-*-15-*-*-*-*-0-iso10646-1
;;  '(default ((t (:family "PT Sans Narrow" :foundry "PARA" :slant normal :weight normal :height 188 :width condensed))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "#181a26" :foreground "gray80" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Menlo"))))
;;  '(ediff-even-diff-A ((t (:background "dim gray"))))
;;  '(ediff-even-diff-B ((t (:background "dim gray"))))
;;  '(ediff-even-diff-C ((t (:background "dim gray"))))
;;  '(ediff-odd-diff-A ((t (:background "dim gray"))))
;;  '(ediff-odd-diff-B ((t (:background "dim gray"))))
;;  '(escape-glyph ((t (:foreground "gray22"))))
;;  '(font-lock-comment-face ((t (:foreground "chocolate4"))))
;;  '(hi-blue-b ((t (:foreground "DodgerBlue1" :weight bold))))
;;  '(highlight ((t (:background "gray9" :height 0.725 :family "Mono"))))
;;  '(highlight-indent-guides-even-face ((t (:background "olive drab"))))
;;  '(highlight-indent-guides-odd-face ((t (:background "dark olive green"))))
;;  '(line-number ((t (:inherit (shadow default) :height 0.7))))
;;  '(linum ((t (:inherit (shadow default) :height 0.7))))
;;  '(markdown-inline-code-face ((t (:inherit markdown-code-face :height 0.8))))
;;  '(markdown-pre-face ((t (:inherit (markdown-code-face font-lock-constant-face) :height 0.8))))
;;  '(mode-line ((t (:background "black" :foreground "SkyBlue2" :box (:line-width -1 :style released-button)))))
;;  '(mode-line-inactive ((t (:inherit mode-line :background "black" :foreground "grey30" :box (:line-width -1 :color "grey40") :weight light))))
;;  '(org-table ((t (:foreground "LightSkyBlue" :height 0.82 :family "Monospace"))))
;;  '(sh-heredoc ((t (:foreground "yellow1" :weight thin)))))

;; https://stackoverflow.com/questions/9999320/how-to-check-if-a-function-e-g-server-running-p-is-available-under-emacs
(if (and (fboundp 'server-running-p) (not (server-running-p))) (server-start))
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)

;; https://www.emacswiki.org/emacs/EmergeDiff
(setq emerge-diff-options "--ignore-all-space")

;; https://www.emacswiki.org/emacs/RevisionControlSystem
(setq vc-rcs-checkin-switches "-l")

;; https://emacs.stackexchange.com/questions/14438/remove-hooks-for-specific-modes
;(add-hook 'after-save-hook 'rcs-ci-co)
;(remove-hook 'after-save-hook 'rcs-ci-co t)
(defun rmail-after-save-hook () t)

;; https://unix.stackexchange.com/questions/20121/how-to-disable-emacs-here-document-completion
(add-hook 'sh-mode-hook
          (lambda ()
            (sh-electric-here-document-mode -1)))

(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "C-s-p") 'dired-prev-subdir)
            ))

;; https://stackoverflow.com/questions/28403647/emacs-25-yank-from-x-windows-primary-clipboard-buffer-with-keyboard
(defun get-primary ()
  (interactive)
  (insert
   (gui-get-primary-selection)))
(global-set-key "\C-c\C-y" 'get-primary)

;; https://www.reddit.com/r/emacs/comments/b65fp1/how_to_show_highlight_parentheses_in_emacs_is_it/
(show-paren-mode)

;; https://www.reddit.com/r/emacs/comments/4rif8d/emacs_lisp_listnonmatchinglines/
(defun list-non-matching-lines ()
  "Show lines *not* matching the regexp."
  (interactive)
  (let ((orig-buf (current-buffer))
        (new-buf "*List Non-matching Lines*"))
    (switch-to-buffer new-buf nil :force-same-window)
    (insert-buffer-substring orig-buf)
    (goto-char (point-min))
    (let ((inhibit-read-only t)) ; Always make the buffer editable
      (call-interactively #'flush-lines))
    (special-mode))) ; Make the new buffer read-only; also allowing bindings like `q'

;; (add-to-list 'tramp-methods '("sls4rcm"
;;                        (tramp-login-program "ssh")
;;                        (tramp-login-args
;;                         (("-l" "ticket_id=9999@sls4unx4")
;;                          ("-p" "%p")
;;                          ("%c")
;;                          ("-e" "none")
;;                          ("-At")
;;                          ("%h")
;;                          ("sls" "-c %u@dbkprcm01"))) ;
;;                        (tramp-async-args
;;                         (("-q")))
;;                        (tramp-remote-shell "/bin/sh")
;;                        (tramp-remote-shell-login
;;                         ("-l"))
;;                        (tramp-remote-shell-args
;;                         ("-c"))
;;                        (tramp-copy-program "scp")
;;                        (tramp-copy-args
;;                         (("-P" "%p")
;;                          ("-p" "%k")
;;                          ("-q")
;;                          ("-r")
;;                          ("%c")))
;;                        (tramp-copy-keep-date t)
;;                        (tramp-copy-recursive t)))

;; (add-to-list 'tramp-methods '("sls4unx4"
;;                        (tramp-login-program "ssh")
;;                        (tramp-login-args
;;                         (("-p" "%p")
;;                          ("%c")
;;                          ("-e" "none")
;;                          ("-At")
;;                          ("-l" "ticket_id=9999@sls4unx4")
;;                          ("%h")
;;                          ("sls" "-c %u"))) ;
;;                        (tramp-async-args
;;                         (("-q")))
;;                        (tramp-remote-shell "/bin/sh")
;;                        (tramp-remote-shell-login
;;                         ("-l"))
;;                        (tramp-remote-shell-args
;;                         ("-c"))
;;                        (tramp-copy-program "scp")
;;                        (tramp-copy-args
;;                         (("-P" "%p")
;;                          ("-p" "%k")
;;                          ("-q")
;;                          ("-r")
;;                          ("%c")))
;;                        (tramp-copy-keep-date t)
;;                        (tramp-copy-recursive t)))

;; (add-to-list 'tramp-methods '("sls4root"
;;                        (tramp-login-program "ssh")
;;                        (tramp-login-args
;;                         (("-p" "%p")
;;                          ("%c")
;;                          ("-e" "none")
;;                          ("-At")
;;                          ("-l" "ticket_id=9999@sls4root")
;;                          ("%h")
;;                          ("sls" "-c %u"))) ;
;;                        (tramp-async-args
;;                         (("-q")))
;;                        (tramp-remote-shell "/bin/sh")
;;                        (tramp-remote-shell-login
;;                         ("-l"))
;;                        (tramp-remote-shell-args
;;                         ("-c"))
;;                        (tramp-copy-program "scp")
;;                        (tramp-copy-args
;;                         (("-P" "%p")
;;                          ("-p" "%k")
;;                          ("-q")
;;                          ("-r")
;;                          ("%c")))
;;                        (tramp-copy-keep-date t)
;;                        (tramp-copy-recursive t)))

;; open next (n) file from other-window for view-mode
(fset 'n1-quick-view-next
   [?q ?n ?o ?\M-x ?c ?o ?n ?f ?  ?m ?o ?d return ?\M-x ?v ?i ?e ?w ?  ?m ?o ?d return])
; (define-key view-mode-map (kbd "N") 'n1-quick-view-next)

;; https://oremacs.com/2017/03/18/dired-ediff/
;; -?- lexical-binding: t -?-
(defun ora-ediff-files ()
  (interactive)
  (let ((files (dired-get-marked-files))
        (wnd (current-window-configuration)))
    (if (<= (length files) 2)
        (let ((file1 (car files))
              (file2 (if (cdr files)
                         (cadr files)
                       (read-file-name
                        "file: "
                        (dired-dwim-target-directory)))))
          (if (file-newer-than-file-p file1 file2)
              (ediff-files file2 file1)
            (ediff-files file1 file2))
          (add-hook 'ediff-after-quit-hook-internal
                    (lambda ()
                      (setq ediff-after-quit-hook-internal nil)
                      (set-window-configuration wnd))))
      (error "no more than 2 files should be marked"))))
; (define-key dired-mode-map "e" 'ora-ediff-files)

(require 'highlight)
(require 'color-moccur)
(if (file-exists-p "~/.emacs.d/site-lisp/moccur-edit.el")
    (require 'moccur-edit nil t))
(if (file-exists-p "~/.emacs.d/site-lisp/sublimity.el")
    (progn 
      (require 'sublimity)
      (require 'sublimity-map)
      (sublimity-mode 1)
      ))
;; || try https://www.emacswiki.org/emacs/MiniMap

;;pep> https://emacs.stackexchange.com/questions/19385/how-to-exit-from-emacs-init-file
;; (with-current-buffer " *load*"
;;   (goto-char (point-max)))
;; (desktop-read)

;; https://emacs.stackexchange.com/questions/34322/set-default-coding-system-utf-8
(set-language-environment "utf-8")
;; https://emacs.stackexchange.com/questions/37485/how-to-set-default-encoding-to-utf-8-and-default-line-ending-to-linux-style
(prefer-coding-system 'utf-8)
;; https://stackoverflow.com/questions/26285046/how-do-i-enable-pdbtrack-python-debugging-in-emacs-24-x-shell
;; (add-hook 'comint-output-filter-functions 'python-pdbtrack-comint-output-filter-function)
;; https://emacs.stackexchange.com/questions/4237/how-to-prevent-emacs-from-breaking-hard-links
(setq backup-by-copying-when-linked t)
(put 'upcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
