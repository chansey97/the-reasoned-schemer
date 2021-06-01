#lang racket
(require "../libs/trs/mk.rkt")
(require "../02_2-list/nullo.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_1-pair/pairo.rkt")
(require "../07-arithmetic/poso.rkt")
(require "../07-arithmetic/gt1o.rkt")
(require "../07-arithmetic/pluso.rkt")

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

; 8.19
(define bound-*o
  (lambda (q p n m)
    succeed))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")


  (test-check "8.20"
              (run 1 (t)
                   (fresh (n m)
                          (*o n m '(1))
                          (== `(,n ,m) t)))
              (list `((1) (1))))

  (test-divergence "8.21"
                   (run 2 (t)
                        (fresh (n m)
                               (*o n m '(1))
                               (== `(,n ,m) t))))
  )
