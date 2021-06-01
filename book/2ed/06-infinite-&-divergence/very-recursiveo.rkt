#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./alwayso.rkt")
(require "./nevero.rkt")
(provide (all-defined-out))

(defrel (very-recursiveo)
  (conde
   ((nevero))
   ((very-recursiveo))
   ((alwayso))
   ((very-recursiveo))
   ((nevero))))

(module+ main
  
  (run 10 q (very-recursiveo))
  )

