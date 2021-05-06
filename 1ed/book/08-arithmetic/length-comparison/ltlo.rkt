#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../07-arithmetic/poso.rkt")
(require "../../07-arithmetic/gt1o.rkt")
(provide (all-defined-out))

; 8.34
(define <lo
  (lambda (n m)
    (conde
     ((== '() n) (poso m))
     ((== '(1) n) (>1o m))
     (else
      (fresh (a x b y)
             (== `(,a . ,x) n) (poso x)
             (== `(,b . ,y) m) (poso y)
             (<lo x y))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "8.35"
              (run 8 (t)
                   (fresh (y z)
                          (<lo `(1 . ,y) `(0 1 1 0 1 . ,z))
                          (== `(,y ,z) t)))
              `((() _.0)
                ((1) _.0)
                ((_.0 1) _.1)
                ((_.0 _.1 1) _.2)
                ((_.0 _.1 _.2 1) (_.3 . _.4))
                ((_.0 _.1 _.2 _.3 1) (_.4 _.5 . _.6))
                ((_.0 _.1 _.2 _.3 _.4 1) (_.5 _.6 _.7 . _.8))
                ((_.0 _.1 _.2 _.3 _.4 _.5 1) (_.6 _.7 _.8 _.9 . _.10))))

  (test-divergence "8.37"
                   (run 1 (n)
                        (<lo n n)))
  )
