#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "./eqlo.rkt")
(require "./ltlo.rkt")
(provide (all-defined-out))

;; 8.40
(defrel (<=lo n m)
  (conde
    ((=lo n m))
    ((<lo n m))))
