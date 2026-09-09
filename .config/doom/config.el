;;; configure doom to use posix shell internally
(setq shell-file-name (executable-find "bash"))

;;; use regular shell externally?
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")
