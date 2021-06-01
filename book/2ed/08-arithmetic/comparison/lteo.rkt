#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "./lto.rkt")
(provide (all-defined-out))

;; 8.46
(defrel (<=o n m)
  (conde
    ((== n m))
    ((<o n m))))
