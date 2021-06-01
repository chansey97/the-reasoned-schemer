#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 7.77
(defrel (poso n)
  (fresh (a d)
    (== `(,a . ,d) n)))
