#lang racket
(require "../libs/trs2/trs2-impl.rkt")

; 1.61
(run* x
      (disj2 (== 'olive x) (== 'oil x)))

(run* x
      (disj2 (== 'oil x) (== 'olive x)))


;; The Law of Swapping conde Lines says that

;; > Swapping two conde lines does not affect the values contributed by conde.

;; But these two examples show that it assuming the order of the return values does not matter.
