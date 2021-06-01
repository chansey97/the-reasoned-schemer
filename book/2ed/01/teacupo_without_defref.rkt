#lang racket
(require "../libs/trs2/trs2-impl.rkt")

;; 1.82

(define (teacupo t)
  (lambda (s)
    (lambda ()
      ((disj2 (== 'tea t) (== 'cup t)) s))))

(module+ main

  (run* x
        (teacupo x))
  )
