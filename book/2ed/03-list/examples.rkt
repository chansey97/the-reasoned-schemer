#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./listo.rkt")

;; (run 5 x
;;      (listo x))
;; '(() (_0) (_0 _1) (_0 _1 _2) (_0 _1 _2 _3))


;; 2ed 3/29
(run 5 x
     (lolo x))
;; '(()
;;   (())
;;   ((_0))
;;   (() ())
;;   ((_0 _1)))

;; 第一版和第二版不同
;; 第二版本是交错的  (()) ((_0)) ((_0 _1)) ((_0 _1)) (_0 _1 _2) 这都属于第一个lolo的list调用
;; 而第1版(listo a) 只用一次null的，而不会继续考虑后面的(listo d)

;; 2ed 3/27
(run 5 x
     (lolo `((a b) (c d) . ,x)))
;; '(()
;;   (())
;;   ((_0))
;;   (() ())
;;   ((_0 _1)))

(run 5 x
     (lolo x))
