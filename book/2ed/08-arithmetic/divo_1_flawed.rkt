#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../07-arithmetic/pluso.rkt")
(require "./mulo.rkt")
(require "./length-comparison/ltelo.rkt")
(require "./comparison/lto.rkt")
(provide (all-defined-out))

; Flawed definition of '/o' from frame 8:54 on page 118.
(defrel (/o n m q r)
  (conde
    ((== '() q) (== n r) (<o n m))
    ((== '(1) q) (== '() r) (== n m)
     (<o r m))      
    ((<o m n) (<o r m)
     (fresh (mq)
       (<=lo mq n)
       (*o m q mq)
       (pluso mq r n)))))

(module+ main

  ;; 8.62
(run* m
      (fresh (r)
             (/o '(1 0 1) m '(1 1 1) r)))


  )
