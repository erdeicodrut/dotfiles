;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Codrut Erdei"
      user-mail-address "codruterdei@gmail.com")

;;; Appearance
;; Font configuration (from Ghostty config)
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 20))

;;; Editor Behavior

;; High scrolloff like vim.opt.scrolloff = 30
(setq scroll-margin 8
      scroll-conservatively 101
      scroll-preserve-screen-position t
      maximum-scroll-margin 0.5)

;; Better undo settings
(setq undo-limit 80000000
      evil-want-fine-undo t)

;; No highlight search (matching Neovim hlsearch = false)
(after! evil
  (setq evil-ex-search-persistent-highlight nil))

;; Indentation settings (matching Neovim: 2 spaces)
(setq-default tab-width 2
              evil-shift-width 2
              indent-tabs-mode nil)

;; Text width (matching Neovim textwidth=120)
(setq-default fill-column 120)

;; Update time (matching Neovim updatetime=50)
(setq idle-update-delay 0.05)
(setq which-key-idle-delay 0.2)
(setq which-key-idle-secondary-delay 0.2)

;;; Centered Scrolling (matching Neovim C-d zz, C-u zz, n zz, N zz)

(after! evil
  (defun my/center-after-scroll ()
    "Center screen after scrolling."
    (evil-scroll-line-to-center nil))

  ;; Center after half-page movements
  (advice-add 'evil-scroll-down :after #'my/center-after-scroll)
  (advice-add 'evil-scroll-up :after #'my/center-after-scroll)

  ;; Center after search
  (advice-add 'evil-search-next :after #'my/center-after-scroll)
  (advice-add 'evil-search-previous :after #'my/center-after-scroll))

;;; Keybindings (matching Neovim)

(map!
 ;; U for redo (matching Neovim keymap)
 :n "U" #'evil-redo

 ;; Move lines in visual mode (matching Neovim J/K in visual mode)
 :v "J" (cmd! (evil-collection-unimpaired-move-text-down 1))
 :v "K" (cmd! (evil-collection-unimpaired-move-text-up 1))

 ;; Window navigation with C-hjkl (matching Neovim/tmux)
 :n "C-h" #'evil-window-left
 :n "C-j" #'evil-window-down
 :n "C-k" #'evil-window-up
 :n "C-l" #'evil-window-right

 ;; Tab/buffer navigation with H/L
 :n "H" #'previous-buffer
 :n "L" #'next-buffer

 ;; Paste without yanking in visual mode (like Neovim <leader>p)
 :v "p" (cmd! (evil-use-register ?_) (evil-visual-paste nil))

 ;; Avy jump with s (like flash.nvim)
 :nvo "s" #'evil-avy-goto-char-timer

 ;; LSP navigation (go to)
 :n "gr" #'lsp-find-references
 :n "gi" #'lsp-find-implementation
 :n "gy" #'lsp-find-type-definition
 :n "gD" nil  ; Disable gD

 ;; Leader keybindings
 :leader
 :desc "Rename symbol" "rn" #'lsp-rename
 :desc "Next quickfix" "q" #'next-error
 :desc "Next diagnostic" "d" #'flycheck-next-error
 :desc "Toggle diagnostics" "tw" #'flycheck-mode)

(after! lsp-mode
  (setq lsp-references-exclude-definition t))

;;; Dired Configuration (Oil.nvim philosophy)

(after! dired
  ;; Better dired defaults
  (setq dired-dwim-target t
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        delete-by-moving-to-trash t
        dired-listing-switches "-alGhv --group-directories-first")

  ;; Use wdired to edit dired buffers like Oil (C-c C-p to enable editing)
  (setq wdired-allow-to-change-permissions t
        wdired-create-parent-directories t))


;;; If you use `org' and don't want your org files in the default location below,
;;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq package-install-upgrade-built-in t)

(after! vertico
  (setq vertico-scroll-margin 0
        vertico-count 20
        vertico-resize t
        vertico-cycle t))

;; For fzf-like fuzzy matching
(use-package! orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))


(map! :map dired-mode-map
      :n "f" #'consult-find)


(setq consult-preview-key 'any)  ; preview automatically
