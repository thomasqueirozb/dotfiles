;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Thomas Queiroz"
      user-mail-address "thomasqueirozb@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one) ;; Default theme
;; (setq doom-theme 'doom-dark+)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-tabs-mode nil)
(setq tab-width 4)

;; Disable automatically closing )
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Include _ in words
(modify-syntax-entry ?_ "w")

(setq-default word-wrap t)

;; TODO visual mode
(map! "C-/" 'comment-line)

;; (define-key evil-normal-state-map (kbd "C-/") 'comment-line)

;; (defun my/commentgv ()
;;         (interactive)
;;         (comment-line)
;;         (evil-visual-restore))

(after! evil
    (define-key evil-normal-state-map (kbd "s") 'evil-substitute)
    (define-key evil-normal-state-map (kbd "0") 'evil-first-non-blank)
    (define-key evil-normal-state-map (kbd "z0") 'evil-beginning-of-line)
    ;; (define-key evil-visual-state-map (kbd "C-/") (lambda ()
    ;;     (interactive)
    ;;     (comment-line)
    ;;     (evil-visual-restore)))
    (define-key evil-normal-state-map "g[" 'flycheck-previous-error)
    (define-key evil-normal-state-map "g]" 'flycheck-next-error)
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
    (define-key evil-normal-state-map (kbd "SPC h h") 'evil-ex-nohighlight))


;; LSP
(setq lsp-enable-folding t)

;; Rust
(after! rustic
    (setq rustic-lsp-server 'rust-analyzer))
(setq lsp-rust-analyzer-server-display-inlay-hints t)
;; (setq lsp-rust-analyzer-proc-macro-enable t) ;; Could be dangerous, don't care
;; (funcall custom-set-variables)

(after! hl-todo
    (setq hl-todo-keyword-faces
        '(("TODO" warning bold)
        ("FIXME" error bold)
        ("HACK" font-lock-constant-face bold)
        ("REVIEW" font-lock-keyword-face bold)
        ("NOTE" success bold)
        ("TIP" success bold)
        ("DEPRECATED" font-lock-doc-face bold)
        ("BUG" error bold)
        ("XXX" font-lock-constant-face bold)
        ("CRITICAL" error bold)
        ("WARNING" error bold)
        ("OPTIMIZE" font-lock-keyword-face bold))))

(defun my/addpylint () (flycheck-add-next-checker 'lsp '(warning . python-pylint) 'append))
(add-hook! python-mode
    (add-hook 'lsp-after-initialize-hook #'my/addpylint))

(add-hook 'magit-mode-hook (lambda () (magit-delta-mode +1)))

;; (prettify-utils-add-hook org-mode
;;                          ("[ ]" "☐")
;;                          ("[X]" "☑")
;;                          ("[-]" "❍"))
;;                          ("[ ]" . "")
;;                          ("[X]" . "")
;;                              '(("#+begin_src" . ?)
      ;; ("#+BEGIN_SRC" . ?)
      ;; ("#+end_src" . ?)
      ;; ("#+END_SRC" . ?)
      ;; ("#+begin_example" . ?)
      ;; ("#+BEGIN_EXAMPLE" . ?)


;; https://www.reddit.com/r/emacs/comments/o04it0/share_your_prettifysymbolsalist/
(setq word-wrap t)

(after! lsp-java
    (setq lombok-path (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar"))

    (push (concat "-javaagent:" lombok-path) (cdr (last lsp-java-vmargs)))
    ;; (push (concat "-Xbootclasspath/a:" lombok-path) (cdr (last lsp-java-vmargs)))
)

;; This whole thing is to prevent rust-analyzer from asking to be restarted when quitting
;; (most likely a bug in persp-mode, since this only happens if *any* workspace was opened)
(defun empty-fun ())
(defun before-save-buffers-kill-terminal-a (&rest a)
    (advice-add #'lsp-mode :override #'empty-fun)
    (advice-add #'lsp :override #'empty-fun))

(advice-add #'save-buffers-kill-terminal :before #'before-save-buffers-kill-terminal-a)
;; (global-whitespace-mode +1)
