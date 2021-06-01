#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "../../07-arithmetic/poso.rkt")
(require "../../07-arithmetic/pluso.rkt")
(require "../length-comparison/eqlo.rkt")
(require "../length-comparison/ltlo.rkt")
(provide (all-defined-out))

;; 8.46
(defrel (<o n m)
  (conde
    ((<lo n m))
    ((=lo n m)
     (fresh (x)
       (poso x)
       (pluso n x m)))))
