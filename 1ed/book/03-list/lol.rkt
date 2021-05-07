#lang racket
(require "../libs/trs/mk.rkt")
(require "../02-pair/null.rkt")
(require "../02-pair/cons.rkt")
(require "./list.rkt")
(provide (all-defined-out))

; 3.16
(define lol?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((list? (car l)) (lol? (cdr l)))
      (else #f))))

; 3.17
(define lolo
  (lambda (l)
    (conde
     ((nullo l) succeed)
     ((fresh (a) 
             (caro l a)
             (listo a))
      (fresh (d)
             (cdro l d)
             (lolo d)))
     (else fail))))


(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")

  (test-check "3.20"
              (run 1 (l)
                   (lolo l))
              `(()))

  (test-check "3.21"
              (run* (q)
                    (fresh (x y) 
                           (lolo `((a b) (,x c) (d ,y)))
                           (== #t q)))
              (list #t))

  (test-check "3.22"
              (run 1 (q)
                   (fresh (x)
                          (lolo `((a b) . ,x))
                          (== #t q)))
              (list #t))

  (test-check "3.23"
              (run 1 (x)
                   (lolo `((a b) (c d) . ,x)))
              `(()))

  (test-check "3.24"
              (run 5 (x)
                   (lolo `((a b) (c d) . ,x)))
              `(()
                (())
                (() ())
                (() () ())
                (() () () ())))

  (test-check ""
              (run 5 (x)
                   (lolo x))
              `(()
                (())
                (() ())
                (() () ())
                (() () () ())))
  

  )

