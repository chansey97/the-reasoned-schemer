#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 3.32, Redefine singletono without using cdro or nullo
(defrel (singletono l)
  (fresh (a)
         (== '(,a) l)))
