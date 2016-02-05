(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (locale-is-utf8-p))
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  ;;(setq utf-translate-cjk-mode 1)
  (set-language-environment 'Chinese-GB18030)
  (setq locale-coding-system 'gbk)
  (set-default-coding-systems 'gbk)
  (set-terminal-coding-system 'gbk)
  (unless (eq system-type 'windows-nt)
   (set-selection-coding-system 'gbk))
  (prefer-coding-system 'gbk))

(provide 'init-locales)
