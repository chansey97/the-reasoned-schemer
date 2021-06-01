#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 1.82

(defrel (teacupo t)
  (disj2 (== 'tea t) (== 'cup t)))

(module+ main

  (run* x
        (teacupo x))
  )
