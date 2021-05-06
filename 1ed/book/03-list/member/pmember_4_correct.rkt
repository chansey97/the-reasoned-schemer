#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(require "./eq-caro.rkt")
(provide (all-defined-out))

; 3.93
(define pmembero
  (lambda (x l)
    (conde
     ((eq-caro l x) 
      (fresh (a d)
             (cdro l `(,a . ,d))))
     ((eq-caro l x) (cdro l '()))
     (else 
      (fresh (d)
             (cdro l d)
             (pmembero x d))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-check "3.94"
              (run 12 (l)
                   (pmembero 'tofu l))
              `((tofu _.0 . _.1)
                (tofu)
                (_.0 tofu _.1 . _.2)
                (_.0 tofu)
                (_.0 _.1 tofu _.2 . _.3)
                (_.0 _.1 tofu)
                (_.0 _.1 _.2 tofu _.3 . _.4)
                (_.0 _.1 _.2 tofu)
                (_.0 _.1 _.2 _.3 tofu _.4 . _.5)
                (_.0 _.1 _.2 _.3 tofu)
                (_.0 _.1 _.2 _.3 _.4 tofu _.5 . _.6)
                (_.0 _.1 _.2 _.3 _.4 tofu)))

  )


