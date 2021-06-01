#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_2-list/nullo.rkt")
(provide (all-defined-out))

;; 3.8
(defrel (listo l)
  (conde
   ((nullo l))
   ((fresh (d)
           (cdro l d)
           (listo d)))))

(module+ main

  (run 5 x
       (listo x))
  ;; '(() (_0) (_0 _1) (_0 _1 _2) (_0 _1 _2 _3))
  
  (run 5 x
       (listo `(a b c . ,x)))
  
  )
