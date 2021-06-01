#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../07-arithmetic/poso.rkt")
(require "../../07-arithmetic/pluso.rkt")
(require "../length-comparison/eqlo.rkt")
(require "../length-comparison/ltlo.rkt")
(provide (all-defined-out))

; 8.46.1
(define <o
  (lambda (n m)
    (condi
     ((<lo n m) succeed)
     ((=lo n m)
      (fresh (x)
             (poso x)
             (+o n x m)))
     (else fail))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "8.47"
              (run* (q)
                    (<o '(1 0 1) '(1 1 1))
                    (== #t q))
              (list #t))

  (test-check "8.48"
              (run* (q)
                    (<o '(1 1 1) '(1 0 1))
                    (== #t q))
              `())

  (test-check "8.49.1"
              (run* (q)
                    (<o '(1 0 1) '(1 0 1))
                    (== #t q))
              `())

  (test-check "8.50"
              (run 6 (n)
                   (<o n `(1 0 1)))
              `(() (0 0 1) (1) (_.0 1)))

  (test-check "8.51"
              (run 6 (m)
                   (<o `(1 0 1) m))
              `((_.0 _.1 _.2 _.3 . _.4) (0 1 1) (1 1 1)))

  (test-divergence "8.52"
                   (run* (n)
                         (<o n n)))
  )
