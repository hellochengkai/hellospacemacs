;;; packages.el --- hellochengkai layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author:  <chengkai@chengkai-deepin>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `hellochengkai-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `hellochengkai/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `hellochengkai/pre-init-PACKAGE' and/or
;;   `hellochengkai/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst hellochengkai-packages
  '( youdao-dictionary
     helm-ag)
  "The list of Lisp packages required by the hellochengkai layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")



(defcustom use-chinese-word-segmentation nil
  "If Non-nil, support Chinese word segmentation(中文分词).

See URL `https://github.com/xuchunyang/chinese-word-at-point.el' for more info."
  :type 'boolean)


(defun -region-or-word ()
  "Return word in region or word at point."
  (if (use-region-p)
      (buffer-substring-no-properties (region-beginning)
                                      (region-end))
    (thing-at-point (if use-chinese-word-segmentation
                        'chinese-or-other-word
                      'word)
                    t)))


(defun youdao-dictionary-search-and-voice-at-point ()
  (interactive)
  (let ((word (-region-or-word)))
    (if word
        (funcall (youdao-dictionary-search-at-point+) (funcall (youdao-dictionary-play-voice-at-point)))
      (message "Nothing to look up"))))

(defun hellochengkai/init-youdao-dictionary ()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "ox" 'youdao-dictionary-search-and-voice-at-point)
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
    (spacemacs/set-leader-keys "ov" 'youdao-dictionary-play-voice-at-point)
    )
  )
(defun hellochengkai/init-helm-ag()
  (use-package helm-ag
    :defer t
    :init
    (spacemacs/set-leader-keys "ps" 'helm-do-ag-project-root)
    )
  )

;;; packages.el ends here
