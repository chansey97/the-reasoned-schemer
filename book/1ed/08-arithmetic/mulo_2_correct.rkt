#lang racket
(require "../libs/trs/mk.rkt")
(require "../02_2-list/nullo.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_1-pair/pairo.rkt")
(require "../07-arithmetic/poso.rkt")
(require "../07-arithmetic/gt1o.rkt")
(require "../07-arithmetic/pluso.rkt")
(provide (all-defined-out))

; 8.10
(define *o
  (lambda (n m p)
    (condi
     ((== '() n) (== '() p))
     ((poso n) (== '() m) (== '() p))  
     ((== '(1) n) (poso m) (== m p))   
     ((>1o n) (== '(1) m) (== n p))
     ((fresh (x z)
             (== `(0 . ,x) n) (poso x)
             (== `(0 . ,z) p) (poso z)
             (>1o m)
             (*o x m z)))
     ((fresh (x y)
             (== `(1 . ,x) n) (poso x)
             (== `(0 . ,y) m) (poso y)
             (*o m n p)))
     ((fresh (x y)
             (== `(1 . ,x) n) (poso x)      
             (== `(1 . ,y) m) (poso y)
             (odd-*o x n m p)))
     (else fail))))

; 8.18
(define odd-*o
  (lambda (x n m p)
    (fresh (q)
           (bound-*o q p n m)
           (*o x m q)
           (+o `(0 . ,q) m p))))

; 8.22
(define bound-*o
  (lambda (q p n m)
    (conde
     ((nullo q) (pairo p))
     (else
      (fresh (x y z)
             (cdro q x)
             (cdro p y)
             (condi
              ((nullo n)
               (cdro m z)
               (bound-*o x y z '()))
              (else
               (cdro n z) 
               (bound-*o x y z m))))))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")

  (test-check "8.1"
              (run 34 (t)
                   (fresh (x y r)
                          (*o x y r)
                          (== `(,x ,y ,r) t)))
              `((() _.0 ())
                ((_.0 . _.1) () ())
                ((1) (_.0 . _.1) (_.0 . _.1))
                ((_.0 _.1 . _.2) (1) (_.0 _.1 . _.2))
                ((0 1) (_.0 _.1 . _.2) (0 _.0 _.1 . _.2))
                ((1 _.0 . _.1) (0 1) (0 1 _.0 . _.1))
                ((0 0 1) (_.0 _.1 . _.2) (0 0 _.0 _.1 . _.2))
                ((1 1) (1 1) (1 0 0 1))
                ((0 1 _.0 . _.1) (0 1) (0 0 1 _.0 . _.1))
                ((1 _.0 . _.1) (0 0 1) (0 0 1 _.0 . _.1))
                ((0 0 0 1) (_.0 _.1 . _.2) (0 0 0 _.0 _.1 . _.2))
                ((1 1) (1 0 1) (1 1 1 1))
                ((0 1 1) (1 1) (0 1 0 0 1))
                ((1 1) (0 1 1) (0 1 0 0 1))
                ((0 0 1 _.0 . _.1) (0 1) (0 0 0 1 _.0 . _.1))
                ((1 1) (1 1 1) (1 0 1 0 1))
                ((0 1 _.0 . _.1) (0 0 1) (0 0 0 1 _.0 . _.1))
                ((1 _.0 . _.1) (0 0 0 1) (0 0 0 1 _.0 . _.1))
                ((0 0 0 0 1) (_.0 _.1 . _.2) (0 0 0 0 _.0 _.1 . _.2))
                ((1 0 1) (1 1) (1 1 1 1))
                ((0 1 1) (1 0 1) (0 1 1 1 1))
                ((1 0 1) (0 1 1) (0 1 1 1 1))
                ((0 0 1 1) (1 1) (0 0 1 0 0 1))
                ((1 1) (1 0 0 1) (1 1 0 1 1))
                ((0 1 1) (0 1 1) (0 0 1 0 0 1))
                ((1 1) (0 0 1 1) (0 0 1 0 0 1))
                ((0 0 0 1 _.0 . _.1) (0 1) (0 0 0 0 1 _.0 . _.1))
                ((1 1) (1 1 0 1) (1 0 0 0 0 1))
                ((0 1 1) (1 1 1) (0 1 0 1 0 1))
                ((1 1 1) (0 1 1) (0 1 0 1 0 1))
                ((0 0 1 _.0 . _.1) (0 0 1) (0 0 0 0 1 _.0 . _.1))
                ((1 1) (1 0 1 1) (1 1 1 0 0 1))
                ((0 1 _.0 . _.1) (0 0 0 1) (0 0 0 0 1 _.0 . _.1))
                ((1 _.0 . _.1) (0 0 0 0 1) (0 0 0 0 1 _.0 . _.1))))

  (test-check "8.4"
              (run* (p)
                    (*o '(0 1) '(0 0 1) p))  
              (list `(0 0 0 1)))

  (test-check "8.23"
              (run 2 (t)
                   (fresh (n m)
                          (*o n m '(1))
                          (== `(,n ,m) t)))
              `(((1) (1))))

  (test-check "8.24"
              (run* (p)
                    (*o '(1 1 1) '(1 1 1 1 1 1) p))
              (list `(1 0 0 1 1 1 0 1 1)))  
  )
