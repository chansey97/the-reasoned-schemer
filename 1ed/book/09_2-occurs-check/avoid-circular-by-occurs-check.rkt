#lang racket
(require "../libs/trs/mk.rkt")
(require "../libs/trs/mkextraforms.rkt")
(require "../libs/test-harness.rkt")

; 9.6
(define u (var 'u)) 
(define v (var 'v))
(define w (var 'w))
(define x (var 'x))
(define y (var 'y))
(define z (var 'z))

;; unify-check保证了不会产生circular，如果输入存在circular，则认为自动unify失败
;; TODO: 我认为更好的方法是报错，需要研究

(test-divergence "9.61"
  (run 1 (x) 
    (== `(,x) x)))

(test-check "9.62"
  (run 1 (q) 
    (fresh (x)
      (== `(,x) x)
      (== #t q)))
  `(#t))

(test-check "9.63"
  (run 1 (q)
    (fresh (x y)
      (== `(,x) y)
      (== `(,y) x)
      (== #t q)))
  `(#t))

(test-check "9.64"
  (run 1 (x) 
    (==-check `(,x) x))
  `())

(test-divergence "9.65"
  (run 1 (x)
    (fresh (y z)
      (== x z)
      (== `(a b ,z) y)
      (== x y))))

(test-check "9.66"
  (run 1 (x)
    (fresh (y z)
      (== x z)
      (== `(a b ,z) y)
      (==-check x y)))
  `())

(test-divergence "9.69"
  (run 1 (x)
    (== `(,x) x)))


