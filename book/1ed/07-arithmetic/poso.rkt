#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

; 7.80.1
(define poso
  (lambda (n)
    (fresh (a d)
           (== `(,a . ,d) n))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")

  (test-check "7.80.2"
              (run* (q)
                    (poso '(0 1 1))
                    (== #t q))
              (list #t))

  (test-check "7.81"
              (run* (q)
                    (poso '(1))
                    (== #t q))
              (list #t))

  (test-check "7.82"
              (run* (q)
                    (poso '())
                    (== #t q))
              `())

  (test-check "7.83"
              (run* (r)
                    (poso r))
              (list `(_.0 . _.1)))

  )
