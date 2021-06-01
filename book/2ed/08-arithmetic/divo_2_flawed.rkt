#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../07-arithmetic/pluso.rkt")
(require "./mulo.rkt")
(require "./length-comparison/ltelo.rkt")
(require "./comparison/lto.rkt")
(provide (all-defined-out))

; Flawed definition of '/o' from frame 8:64 on page 120.
(defrel (/o n m q r)
  (fresh (mq)
    (<o r m)
    (<=lo mq n)
    (*o m q mq)
    (pluso mq r n)))

