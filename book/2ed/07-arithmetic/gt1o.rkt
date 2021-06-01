#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 7.83
(defrel (>1o n)
  (fresh (a ad dd)
    (== `(,a ,ad . ,dd) n)))
