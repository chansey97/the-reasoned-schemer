#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./addero.rkt")
(provide (all-defined-out))

;; 7.114
(defrel (pluso n m k)
  (addero 0 n m k))
