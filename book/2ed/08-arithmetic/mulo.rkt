#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../07-arithmetic/poso.rkt")
(require "../07-arithmetic/gt1o.rkt")
(require "../07-arithmetic/pluso.rkt")
(provide (all-defined-out))

;;; Here are the key parts of Chapter 8
;; 8:9
(defrel (*o n m p)
  (conde
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
       (odd-*o x n m p)))))

(defrel (odd-*o x n m p)
  (fresh (q)
    (bound-*o q p n m)
    (*o x m q)
    (pluso `(0 . ,q) m p)))

;; 8.24
(defrel (bound-*o q p n m)
  (conde
    ((== '() q) (poso p))
    ((fresh (a0 a1 a2 a3 x y z)
       (== `(,a0 . ,x) q)
       (== `(,a1 . ,y) p)
       (conde
         ((== '() n)
          (== `(,a2 . ,z) m)
          (bound-*o x y z '()))
         ((== `(,a3 . ,z) n) 
          (bound-*o x y z m)))))))
