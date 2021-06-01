#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./pluso.rkt")
(provide (all-defined-out))

;; 7.116
(defrel (minuso n m k)
  (pluso m k n))
