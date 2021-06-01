#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../../02_1-pair/conso.rkt")
(require "./eq-caro.rkt")
(provide (all-defined-out))

; 3.83
(define pmembero
  (lambda (x l)
    (conde
     ((nullo l) fail)
     ((eq-caro l x) (cdro l '()))
     ((eq-caro l x) succeed)
     (else 
      (fresh (d)
             (cdro l d)
             (pmembero x d))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-check "3.84"
              (run* (q)
                    (pmembero 'tofu `(a b tofu d tofu))
                    (== #t q))
              `(#t #t #t))
  
  (run* (q)
        (pmembero 'tofu `(a b tofu d x)))
  ;; '(_.0)

  (run* (q)
        (pmembero 'tofu `(a b tofu d . x)))
  ;; '(_.0) ; wrong, should '()

  ;; another wrong point is 3.84
  
  )
