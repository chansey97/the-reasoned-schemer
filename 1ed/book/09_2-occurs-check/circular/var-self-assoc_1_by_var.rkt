#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")

; 9.6
(define u (var 'u)) 
(define v (var 'v))
(define w (var 'w))
(define x (var 'x))
(define y (var 'y))
(define z (var 'z))

;; circular type 1
;; 直接通过变量的循环关联

`((,x . ,y) (,z . ,x) (,y . ,z))
;; '((#(x) . #(y)) (#(z) . #(x)) (#(y) . #(z)))
`((,x . ,x))
;; '((#(x) . #(x)))

;; 注意：
;; 对这类circular进行walk可能导致loop!
(test-divergence "9.18"
                 (walk x `((,x . ,y) (,z . ,x) (,y . ,z))))

;; 但是如果这个substitution是通过unify构造的，则不会出现这样circular
;; 因此，通过unify构造的substitution，对其walk不会loop

;; Frame 9:21
;; If x is a variable and s is a substitution built
;; by unify, does(walk x s) always have a
;; value?

;; Yes!

((all 
  (== y z)
  (== z x)
  (== x y)) '())
;; '((#(z) . #(x)) (#(y) . #(z)))
;; unify不会构造这样circular ((,x . ,y) (,z . ,x) (,y . ,z))

(unify z x
       (unify y z empty-s))
;; '((#(z) . #(x)) (#(y) . #(z)))

(unify x y
       (unify z x
              (unify y z empty-s)))
;; '((#(z) . #(x)) (#(y) . #(z)))
;; 注意：最外层的unify x y并没有其效果，因为y -> z -> x 和 x本身unify了
;; 不会产生 ((#(x) . #(y)) (#(z) . #(x)) (#(y) . #(z)))

(walk x (unify x y
               (unify z x
                      (unify y z empty-s))))
;; '#(x)


