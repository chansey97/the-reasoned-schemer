#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_1-pair/conso.rkt")
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

  ;; Note that the results of 5.53 and 5.55 are the same
  ;; 因为5.55前面几个输出会失败，所以最终会和5.53一样
  
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

