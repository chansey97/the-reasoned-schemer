#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

(defrel (onceo g)
  (condu
   (g succeed)
   (succeed fail)))

(module+ main

  ;; 8.20
  (defrel (teacupo t)
    (conde
     ((== 'tea t))
     ((== 'cup t))))

  ;; 8.21
  (run* x (onceo (teacupo x)))

  )

