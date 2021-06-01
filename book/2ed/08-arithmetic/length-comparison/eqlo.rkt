#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "../../07-arithmetic/poso.rkt")
(provide (all-defined-out))

;; 8.28
(defrel (=lo n m)
  (conde
    ((== '() n) (== '() m))
    ((== '(1) n) (== '(1) m))
    ((fresh (a x b y)
       (== `(,a . ,x) n) (poso x)
       (== `(,b . ,y) m) (poso y)
       (=lo x y)))))
