#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

; 7.86.1
(define >1o
  (lambda (n)
    (fresh (a ad dd)
           (== `(,a ,ad . ,dd) n))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")

  (test-check "7.86.2"
              (run* (q)
                    (>1o '(0 1 1))
                    (== #t q))
              (list #t))

  (test-check "7.87"
              (run* (q)
                    (>1o '(0 1))
                    (== #t q))
              `(#t))

  (test-check "7.88"
              (run* (q)
                    (>1o '(1))
                    (== #t q))
              `())

  (test-check "7.89"
              (run* (q)
                    (>1o '())
                    (== #t q))
              `())

  (test-check "7.90"
              (run* (r)
                    (>1o r))
              (list `(_.0 _.1 . _.2)))
  
  )
