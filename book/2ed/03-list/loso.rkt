#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_2-list/nullo.rkt")
(require "./singletono.rkt")
(provide (all-defined-out))

;; 3.33
(defrel (loso l)
  (conde
   ((nullo l))
   ((fresh (a)
           (caro l a)
           (singletono a))
    (fresh (d)
           (cdro l d)
           (loso d)))))
