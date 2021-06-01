#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "../../07-arithmetic/poso.rkt")
(require "../../07-arithmetic/gt1o.rkt")
(provide (all-defined-out))

;; 8.36
(defrel (<lo n m)
  (conde
    ((== '() n) (poso m))
    ((== '(1) n) (>1o m))
    ((fresh (a x b y)
       (== `(,a . ,x) n) (poso x)
       (== `(,b . ,y) m) (poso y)
       (<lo x y)))))
