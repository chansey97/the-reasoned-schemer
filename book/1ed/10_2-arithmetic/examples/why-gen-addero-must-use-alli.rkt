#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../07-arithmetic/full-addero.rkt")
(require "../../07-arithmetic/poso.rkt")
(require "../../07-arithmetic/gt1o.rkt")

;; If gen-addero use all instead of alli, then gen&testo will loop.
;; This proved that o+ will miss values!
;; Therefore it is wrong to use all in gen-addero

; 10.57
(define gen-addero
  (lambda (d n m r)
    (fresh (a b c e x y z)
           (== `(,a . ,x) n)
           (== `(,b . ,y) m) (poso y)       
           (== `(,c . ,z) r) (poso z)
           (all
            (full-addero d a b c e)
            (addero e x y z)))))

; 7.118.1
(define addero
  (lambda (d n m r)
    (condi
     ((== 0 d) (== '() m) (== n r))
     ((== 0 d) (== '() n) (== m r)
               (poso m))
     ((== 1 d) (== '() m)
               (addero 0 n '(1) r))
     ((== 1 d) (== '() n) (poso m)
               (addero 0 '(1) m r))
     ((== '(1) n) (== '(1) m)
                  (fresh (a c)
                         (== `(,a ,c) r)
                         (full-addero d 1 1 a c)))
     ((== '(1) n) (gen-addero d n m r))
     ((== '(1) m) (>1o n) (>1o r)
                  (addero d '(1) n r))
     ((>1o n) (gen-addero d n m r))
     (else fail))))

; 7.128
(define +o
  (lambda (n m k)
    (addero 0 n m k)))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-divergence "10.58"
                   (run 1 (q) 
                        (gen&testo +o '(0 1) '(1 1) '(1 0 1))))

  (test-divergence "10.62"
                   (run* (q)
                         (enumerateo +o q '(1 1 1))))
  )
