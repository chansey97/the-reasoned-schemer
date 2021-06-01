#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../listo.rkt")
(require "./eq-caro.rkt")
(provide (all-defined-out))

;; Note that the correct version of pmembero doesn't provided in 1ed
;; The following uses 2ed definition.
;; 增加交错
;; 仍然和第二版的交错不一样

(define pmembero
  (lambda (x l)
    (condi
     ((eq-caro l x)
      (fresh (d)
             (cdro l d)
             (listo d)))   
     (else 
      (fresh (d)
             (cdro l d)
             (pmembero x d))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (run 12 (l)
       (pmembero 'tofu l))
  
  (run* (q)
        (pmembero 'tofu `(a b tofu d x)))
  ;; '(_.0)

  (run* (q)
        (pmembero 'tofu `(a b tofu d . x)))
  ;; '() ; OK

  )


