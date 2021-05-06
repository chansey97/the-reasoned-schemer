#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/cons.rkt")
(provide (all-defined-out))

; 5.52
(define unwrapo
  (lambda (x out)
    (conde
     (succeed (== x out))
     (else 
      (fresh (a)
             (caro x a)
             (unwrapo a out))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "5.53"
              (run 5 (x)
                   (unwrapo x 'pizza))
              `(pizza
                (pizza . _.0)
                ((pizza . _.0) . _.1)
                (((pizza . _.0) . _.1) . _.2)
                ((((pizza . _.0) . _.1) . _.2) . _.3)))

  (test-check "5.54"
              (run 5 (x)
                   (unwrapo x '((pizza))))
              `(((pizza))
                (((pizza)) . _.0)
                ((((pizza)) . _.0) . _.1)
                (((((pizza)) . _.0) . _.1) . _.2)
                ((((((pizza)) . _.0) . _.1) . _.2) . _.3)))

  (test-check "5.55"
              (run 5 (x)
                   (unwrapo `((,x)) 'pizza))
              `(pizza
                (pizza . _.0)
                ((pizza . _.0) . _.1)
                (((pizza . _.0) . _.1) . _.2)
                ((((pizza . _.0) . _.1) . _.2) . _.3)))
  )

