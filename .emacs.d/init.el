;; load-pathを追加
(let ((default-directory (expand-file-name "~/.emacs.d/elisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))
;;(defun add-to-load-path (&rest paths)
;;  (let (path)
;;    (dolist (path paths paths)
;;      (let ((default-directory
;;              (expand-file-name (concat user-emacs-directory path))))
;;        (add-to-list 'load-path default-directory)
;;        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;            (normal-top-level-add-subdirs-to-load-path))))))

;;(add-to-load-path "elisp" "conf" "public_repos")

;; load environment value
(defun eshell-mode-hook-func ()
(setq eshell-path-env (concat "/usr/local/pgsql/bin:" eshell-path-env))
(setenv "PATH" (concat "/usr/local/pgsql/bin:" (getenv "PATH"))))

(add-hook 'eshell-mode-hook 'eshell-mode-hook-func)

(set-default-coding-systems 'utf-8-unix)

;;クリップボードを共有する
;;(global-set-key "\M-w" 'clipboard-kill-ring-save)
;;(global-set-key "\C-w" 'clipboard-kill-region)

;; move split window
(global-set-key '[up] 'windmove-up)
(global-set-key '[down] 'windmove-down)
(global-set-key '[right] 'windmove-right)
(global-set-key '[left] 'windmove-left)

(global-font-lock-mode t)

(column-number-mode t)

;; grep-edit: grep から直接置換
;;(install-elisp "http://www.emacswiki.org/emacs/download/grep-edit.el")
(require 'grep-edit)

(require 'e2wm);
(global-set-key (kbd "M-@") 'e2wm:start-management);
;;
;;(defun add-to-load-path (&rest paths)
;;  (let (path)
;;    (dolist (path paths paths)
;;      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
;;        (add-to-list 'load-path default-directory)
;;        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;            (normal-top-level-add-subdirs-to-load-path))))))

;;pathとconfディレクトリをサブディレクトリごとload-pathに追加
;;(add-to-load-path "elisp" "conf")

;; (install-elisp "http://www.emacswiki.org/emacs/download/auto-install.el")
(when (require 'auto-install nil t)
  ;; インストールディレクトリを設定する 初期値は ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelispの名前を取得する (起動時にうるさいのでコメントアウト)
  ;;(auto-install-update-emacswiki-package-name t)
  ;; 必要であればプロキシの設定
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  (auto-install-compatibility-setup))

;; elsceen(タブ)の設定
;;(require 'elscreen)
;;(global-set-key "\M-t" 'elscreen-create)
;;(global-set-key "\M-T" 'elscreen-clone)
;; not display startup message
(setq inhibit-startup-message t)

;; タイトルバーにフルパスを表示
(setq frame-title-format "%f")

;; C-mで改行の後、インデントする
(global-set-key "\C-m" 'newline-and-indent)

;;; 折り返しトグルコマンド
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;;; C-o でwindowを切り替える
(global-set-key "\C-o" 'other-window)

;;; C-h を backspace として使う
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;;; helpコマンド
(define-key global-map (kbd "C-x ?") 'help-command)

;;; M-g で指定行へジャンプ
(global-set-key "\M-g" 'goto-line)

;; タブの代わりにスペースを使う
(setq-default indent-tabs-mode nil)

;;; 選択範囲(リージョン)のハイライト
(transient-mark-mode 1)

;;; 対応する{}をハイライト
(show-paren-mode 1)

;; バックアップファイルを作成しない
(setq backup-inhibited t)
(setq make-backup-files nil)

;;(setq hl-line-face 'underline)
;;(global-hl-line-mode)

;; dispay full path
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; スタートメッセージを表示しない
(setq inhibit-startup-message t)

;; メニューバーを表示しない
;;(menu-bar-mode 0)

;; redo, undoの設定(redo.el) (いまいち、使えていない)
;;(require 'redo+)
;;(global-set-key (kbd "C-M-/") 'redo)
;;(setq undo-no-redo t)
;;(setq undo-limit 600000)
;;(setq undo-strong-limit 900000)

(require 'undo-tree)
(global-undo-tree-mode)

;; 矩形選択を簡単に
;; 行番号表示
(require 'linum)
(global-linum-mode t)

;; web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq web-mode-markup-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(add-hook 'web-mode-hook  'web-mode-hook)
(custom-set-faces
 '(web-mode-server-face
   ((t (:foreground "#82AE46"))))                          ; template Block
 '(web-mode-javascript-face
   ((t (:foreground "#82AE46"))))                          ; javascript 
 '(web-mode-variable-name-face
   ((t (:foreground "#660066"))))
 '(web-mode-doctype-face
   ((t (:foreground "#82AE46"))))                          ; doctype
 '(web-mode-html-tag-face
   ((t (:foreground "#000080" :weight bold))))             ; 要素名
 '(web-mode-html-attr-name-face
   ((t (:foreground "#000000"))))                          ; 属性名など
 ;;'(web-mode-html-attr-value-face
 ;;  ((t (:foreground "#82AE46"))))                          ; 属性値
 '(web-mode-comment-face
   ((t (:foreground "#8A8A8A"))))                          ; コメント
 '(web-mode-server-comment-face
   ((t (:foreground "#FF7F00"))))                          ; コメント
)

;; php mode
(autoload 'php-mode "php-mode")
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
;;(add-hook 'php-mode-hook '(lambda ()
;;                            (setq c-basic-offset 4)
;;                            (setq c-tab-width 4)
;;                            (setq c-indent-level 4)
;;                            (setq tab-width 4)
;;                            (setq indent-tabs-mode t)
;;                            (setq-default tab-width 4)
;;                            ))

;; js mode
(setq js-indent-level 4)

;; テーマカラーの設定
;(when (require 'color-theme nil t)
;  (color-theme-initialize)
;  (color-theme-blippblopp))

;; 全角スペースの可視化
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "snow"))) nil)
(defface my-face-u-1 '((t (:foreground "gray26" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
