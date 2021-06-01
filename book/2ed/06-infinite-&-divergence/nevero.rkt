#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

(defrel (nevero)
  (nevero))

(module+ main
  (require "../libs/test-harness.rkt")
  (require "./alwayso.rkt")
  
  ;; 6.21
  (test-divergence "6.21"
                   (run 1 q
                        (conde
                         (succeed)
                         ((nevero)))
                        fail))

  ;; 6.23
  (run 6 q
       (conde
        ((== 'spicy q)
         (nevero))
        ((== 'hot q)
         (nevero))
        ((== 'apple q)
         (alwayso))
        ((== 'cider q)
         (alwayso))))
  
  )
