#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_2-list/nullo.rkt")
(require "./listo.rkt")
(provide (all-defined-out))

;; 3.22
(defrel (lolo l)
  (conde
   ((nullo l))
   ((fresh (a)
           (caro l a)
           (listo a))
    (fresh (d)
           (cdro l d)
           (lolo d)))))

(module+ main
  ;; 3.29
  (run 5 x
       (lolo x))

  ;; '(()
  ;;   (())
  ;;   ((_0))
  ;;   (() ())
  ;;   ((_0 _1)))

  )

