#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/cons.rkt")
(require "../../02-pair/pair.rkt")
(provide (all-defined-out))

; 5.41.1
(define unwrap
  (lambda (x)
    (cond
      ((pair? x) (unwrap (car x)))
      (else x))))

; 5.45
(define unwrapo
  (lambda (x out)
    (conde
     ((pairo x)
      (fresh (a)
             (caro x a)
             (unwrapo a out)))
     (else (== x out)))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "5.41.2"
              (unwrap '((((pizza)))))
              `pizza)

  (test-check "5.42"
              (unwrap '((((pizza pie) with)) extra cheese))
              `pizza)

  (test-check "5.46"
              (run* (x)
                    (unwrapo '(((pizza))) x))
              `(pizza
                (pizza)
                ((pizza))
                (((pizza)))))

  (test-divergence "5.48"
                   (run 1 (x)
                        (unwrapo x 'pizza)))

  (test-divergence "5.49"
                   (run 1 (x)
                        (unwrapo `((,x)) 'pizza)))

  )
