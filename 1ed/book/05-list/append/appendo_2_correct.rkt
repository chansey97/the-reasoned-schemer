#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(provide (all-defined-out))

; 5.31
(define appendo
  (lambda (l s out)
    (conde
     ((nullo l) (== s out))
     (else 
      (fresh (a d res)
             (conso a d l)
             (conso a res out)
             (appendo d s res))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  ; 5.26.2
  (define appendxyanswer
    `((() (cake with ice d t))
      ((cake) (with ice d t))
      ((cake with) (ice d t))
      ((cake with ice) (d t))
      ((cake with ice d) (t))
      ((cake with ice d t) ())))

  (test-check "5.32"
              (run 7 (r)
                   (fresh (x y)
                          (appendo x y `(cake with ice d t))
                          (== `(,x ,y) r)))
              appendxyanswer)

  (test-check "5.33"
              (run 7 (x)
                   (fresh (y z)
                          (appendo x y z)))
              `(()
                (_.0)
                (_.0 _.1)
                (_.0 _.1 _.2)
                (_.0 _.1 _.2 _.3)
                (_.0 _.1 _.2 _.3 _.4)
                (_.0 _.1 _.2 _.3 _.4 _.5)))

  (test-check "5.34"
              (run 7 (y)
                   (fresh (x z)
                          (appendo x y z)))
              `(_.0 
                _.0 
                _.0 
                _.0
                _.0 
                _.0  
                _.0))

  (test-check "5.36"
              (run 7 (z)
                   (fresh (x y)
                          (appendo x y z)))
              `(_.0
                (_.0 . _.1)
                (_.0 _.1 . _.2)
                (_.0 _.1 _.2 . _.3)
                (_.0 _.1 _.2 _.3 . _.4)
                (_.0 _.1 _.2 _.3 _.4 . _.5)
                (_.0 _.1 _.2 _.3 _.4 _.5 . _.6)))

  (test-check "5.37"
              (run 7 (r)
                   (fresh (x y z)
                          (appendo x y z)
                          (== `(,x ,y ,z) r)))
              `((() _.0 _.0)
                ((_.0) _.1 (_.0 . _.1))
                ((_.0 _.1) _.2 (_.0 _.1 . _.2))
                ((_.0 _.1 _.2) _.3 (_.0 _.1 _.2 . _.3))
                ((_.0 _.1 _.2 _.3) _.4 (_.0 _.1 _.2 _.3 . _.4))
                ((_.0 _.1 _.2 _.3 _.4) _.5 (_.0 _.1 _.2 _.3 _.4 . _.5))
                ((_.0 _.1 _.2 _.3 _.4 _.5) _.6 (_.0 _.1 _.2 _.3 _.4 _.5 . _.6))))
  
  )
