;-------La division Robotique de l'Institut de recherche d'Hydro-Québec--------
; 
; Nom     : (require 'ispell-ireq)
; Fonction: Ajustements pour ispell.el à l'IREQ
; Fichiers: ispell-ireq.el
; Notes   : 
; 
; Créé    :  4 mai 94 ----------- Martin Boyer <mboyer@ireq-robot.hydro.qc.ca>
; Modifié : 31 décembre 94 ----3- Martin Boyer <mboyer@ireq-robot.hydro.qc.ca>
;           Copyright (c) 1994 Hydro-Québec
; 
; Historique: 
;------------------------------------------------------------------------------

(provide 'ispell-ireq)

(autoload (fmakunbound 'ispell-word) "ispell"
  "Vérification de l'orthographe d'un mot (autochargé)." t)
(autoload (fmakunbound 'ispell-region) "ispell"
  "Vérification de l'orthographe d'une région (autochargé)." t)
(autoload (fmakunbound 'ispell-buffer) "ispell"
  "Vérification de l'orthographe d'un fichier (autochargé)." t)
(autoload (fmakunbound 'ispell-complete-word) "ispell"
  "Recherche et complétion d'un mot dans le dictionnaire courant (autochargé)." t)
(autoload 'ispell-change-dictionary "ispell"
  "Changement du dictionnaire courant (autochargé)." t)

(setq ispell-dictionary-alist		; sk  9-Aug-1991 18:28
  '((nil				; default (english.aff)
     "[A-Za-z]" "[^A-Za-z]" "[-']" nil ("-B") nil)
    ("english"				; make english explicitly selectable
     "[A-Za-z]" "[^A-Za-z]" "[-']" nil ("-B") nil)
    ("francais"				; francais.aff
     "[A-Za-zÀÂÇ-ËÎÏÔÙÛÜàâç-ëîïôùûü]" "[^A-Za-zÀÂÇ-ËÎÏÔÙÛÜàâç-ëîïôùûü]"
     "[-']" t nil)
    ("francais-TeX"			; francais.aff
     "[A-Za-zÀÂÇ-ËÎÏÔÙÛÜàâç-ëîïôùûü\\]" "[^A-Za-zÀÂÇ-ËÎÏÔÙÛÜàâç-ëîïôùûü\\]"
     "[-'^`\"]" t nil "~tex")
    ))

;; Redéfinition pour inclure la nouvelle liste de dictionnaires
(if ispell-menu-map
  (let ((dicts (reverse (cons (cons "default" nil) ispell-dictionary-alist)))
	  name)
      (setq ispell-menu-map (make-sparse-keymap "Spell"))
      (while dicts
	(setq name (car (car dicts))
	      dicts (cdr dicts))
	(if (stringp name)
	    (define-key ispell-menu-map (vector (intern name))
	      (cons (concat "Select " (capitalize name))
		    (list 'lambda () '(interactive)
			  (list 'ispell-change-dictionary name))))))
      ;; Why do we need an alias here?
      (defalias 'ispell-menu-map ispell-menu-map)
      ;; Define commands in opposite order you want them to appear in menu.
      (define-key ispell-menu-map [ispell-change-dictionary]
	'("Change Dictionary" . ispell-change-dictionary))
      (define-key ispell-menu-map [ispell-kill-ispell]
	'("Kill Process" . ispell-kill-ispell))
      (define-key ispell-menu-map [ispell-pdict-save]
	'("Save Dictionary" . (lambda () (interactive) (ispell-pdict-save t))))
      (define-key ispell-menu-map [ispell-complete-word]
	'("Complete Word" . ispell-complete-word))
      (define-key ispell-menu-map [ispell-complete-word-interior-frag]
	'("Complete Word Frag" . ispell-complete-word-interior-frag))
      (define-key ispell-menu-map [ispell-continue]
	'("Continue Check" . ispell-continue))
      (define-key ispell-menu-map [ispell-region]
	'("Check Region" . ispell-region))
      (define-key ispell-menu-map [ispell-word]
	'("Check Word" . ispell-word))
      (define-key ispell-menu-map [ispell-buffer]
	'("Check Buffer" . ispell-buffer))
      (define-key ispell-menu-map [ispell-message]
	'("Check Message" . ispell-message))
      (define-key ispell-menu-map [ispell-help]
	'("Help" . (lambda () (interactive) (describe-function 'ispell-help))))
      ))

