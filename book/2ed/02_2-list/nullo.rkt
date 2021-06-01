#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 2.33
(defrel (nullo x)
  (== '() x))
