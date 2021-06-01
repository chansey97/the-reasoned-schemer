#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

(defrel (bit-ando x y r)
  (conde
    ((== 0 x) (== 0 y) (== 0 r))
    ((== 1 x) (== 0 y) (== 0 r))
    ((== 0 x) (== 1 y) (== 0 r))
    ((== 1 x) (== 1 y) (== 1 r))))
