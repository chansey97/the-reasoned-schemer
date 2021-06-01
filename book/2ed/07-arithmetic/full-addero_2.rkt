#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./bit-ops/bit-xoro.rkt")
(require "./bit-ops/bit-ando.rkt")
(provide (all-defined-out))

;; 7.12
;; (defrel (half-addero x y r c)
;;   (bit-xoro x y r)
;;   (bit-ando x y c))

;; Alternative definition of 'half-addero' from frame 7:12 on page 87.
(defrel (half-addero x y r c)
  (conde
    ((== 0 x) (== 0 y) (== 0 r) (== 0 c))
    ((== 1 x) (== 0 y) (== 1 r) (== 0 c))
    ((== 0 x) (== 1 y) (== 1 r) (== 0 c))
    ((== 1 x) (== 1 y) (== 0 r) (== 1 c))))

;; Definition of 'full-addero' from frame 7:15 on page 87.
(defrel (full-addero b x y r c)
  (fresh (w xy wz)
    (half-addero x y w xy)
    (half-addero w b r wz)
    (bit-xoro xy wz c)))
