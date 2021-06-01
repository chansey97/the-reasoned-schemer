#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 2.6
(defrel (caro p a)
  (fresh (d)
         (== (cons a d) p)))

;; 2.13
(defrel (cdro p d)
  (fresh (a)
         (== (cons a d) p)))

(defrel (conso a d p)
  (== `(,a . ,d) p))
