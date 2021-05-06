#lang racket
(require "../libs/trs/mk.rkt")
(require "../07-arithmetic/subo.rkt")
(provide (all-defined-out))

; 10.26.1
(define bumpo
  (lambda (n x)
    (conde
     ((== n x) succeed)
     (else
      (fresh (m)
             (-o n '(1) m)
             (bumpo m x))))))


(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "10.26.2"
              (run* (x)
                    (bumpo '(1 1 1) x))
              `((1 1 1)
                (0 1 1)
                (1 0 1)
                (0 0 1)
                (1 1)
                (0 1)
                (1)
                ()))
  )
