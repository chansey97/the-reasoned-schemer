#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./conso.rkt")

;; 2.27
(run* l
      (fresh (d t x y w)
             (conso w '(n u s) t)
             (cdro l t)
             (caro l x)
             (== 'b x)
             (cdro l d)
             (caro d y)
             (== 'o y)))
