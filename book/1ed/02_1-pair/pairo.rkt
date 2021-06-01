#lang racket
(require "../libs/trs/mk.rkt")
(require "./conso.rkt")
(provide (all-defined-out))

;; 2.53
(define pairo
  (lambda (p)
    (fresh (a d)
           (conso a d p))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")

  (test-check "2.54"
              (run* (q)
                    (pairo (cons q q))
                    (== #t q))
              `(#t))

  (test-check "2.55"
              (run* (q)
                    (pairo '())
                    (== #t q))
              `())

  (test-check "2.56"
              (run* (q)
                    (pairo 'pair)
                    (== #t q))
              `())

  (test-check "2.57"
              (run* (x) 
                    (pairo x))
              (list `(_.0 . _.1)))

  (test-check "2.58"
              (run* (r) 
                    (pairo (cons r 'pear)))
              (list `_.0))

  )
