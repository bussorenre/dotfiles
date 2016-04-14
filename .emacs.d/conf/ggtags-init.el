(require 'ggtags)
(add-hook 'c-mode-common-hook
	  (lambda ()
		  (when (derived-mode-p 'c-mode 'C++-mode)
		    (ggtags-mode 1))))


