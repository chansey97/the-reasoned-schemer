#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(require "./eq-caro.rkt")
(provide (all-defined-out))

; 3.80.1
(define pmembero
  (lambda (x l)
    (conde
     ((nullo l) fail)
     ((eq-caro l x) (cdro l '()))
     (else
      (fresh (d)
             (cdro l d)
             (pmembero x d))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-check "3.80.2"
              (run 5 (l)
                   (pmembero 'tofu l))
              `((tofu)
                (_.0 tofu)
                (_.0 _.1 tofu)
                (_.0 _.1 _.2 tofu)
                (_.0 _.1 _.2 _.3 tofu)))

  (test-check "3.81"
              (run* (q)
                    (pmembero 'tofu `(a b tofu d tofu))
                    (== #t q))
              `(#t))

  )




