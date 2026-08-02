;;; lang/ada/auoload.el -*- lexical-binding: t; -*-

(defun +ada--barf-unless-project ()
  (unless (locate-dominating-file default-directory "alire.toml")
    (user-error "Not inside an Alire project")))


;;;###autoload
(defun +ada/alr-build ()
  "Run 'alr build' in the current project."
  (interactive)
  (+ada--barf-unless-project)
  (compile "alr build"))

;;;###autoload
(defun +ada/alr-run ()
  "Run 'alr run' in the current project."
  (interactive)
  (+ada--barf-unless-project)
  (compile "alr run"))

;;;###autoload
(defun +ada/alr-clean ()
  "Run 'alr clean' in the current project."
  (interactive)
  (+ada--barf-unless-project)
  (compile "alr clean"))

;;;###autoload
(defun +ada/alr-test ()
  "Run 'alr test' in the current project."
  (interactive)
  (+ada--barf-unless-project)
  (compile "alr test"))

;;;###autoload
(defun +ada/alr-prove ()
  "Run 'alr prove' in the current project."
  (interactive)
  (+ada--barf-unless-project)
  (compile "alr gnatprove"))
