;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cmake-mode consult glsl-mode magit marginalia markdown-mode
		multiple-cursors orderless rust-mode toml-mode
		transient vertico yaml-mode))
 '(safe-local-variable-values
   '((cmake-tab-width . 2) (cmake-tab-width . 4)
     (eval setq-local tags-file-name
	   (expand-file-name "TAGS" (project-root (project-current))))
     (eval when (fboundp 'rainbow-mode) (rainbow-mode 1)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
