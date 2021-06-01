#lang racket
(require "../libs/trs/mk.rkt")
(require (file "../10_1-conda-&-condu/once.rkt"))
(provide (all-defined-out))

; 10.27.1
(define gen&testo
  (lambda (op i j k)
    (onceo
     (fresh (x y z)
            (op x y z)
            (== i x)
            (== j y)
            (== k z)))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  (require "../07-arithmetic/pluso.rkt")

  (test-check "10.27.2"
              (run* (q)
                    (gen&testo +o '(0 0 1) '(1 1) '(1 1 1))
                    (== #t q))
              (list #t))

  (test-divergence "10.42"
                   (run 1 (q)
                        (gen&testo +o '(0 0 1) '(1 1) '(0 1 1))))

  )


