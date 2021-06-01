#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../02_2-list/nullo.rkt")
(provide (all-defined-out))

;; The First Commandment
;; Within each sequence of goals, move non-recursive goals before recursive goals.

;; 但这样移动了之后，损失了原来的translation的cps语义。

;; 4.41
(defrel (appendo l t out)
  (conde
   ((nullo l) (== t out))
   ((fresh (a d res)
           (conso a d l)
           (conso a res out) ; move non-recursive goals before recursive goals
           (appendo d t res) ;
           ))))

(module+ main
  (require "../../libs/test-harness.rkt")
  
  (run 7 (x y)
       (appendo x y '(cake & ice d t)))

  )
