#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../../02_1-pair/conso.rkt")
(provide (all-defined-out))

(define swappendo
  (lambda-limited 5 (l s out)
                  (conde
                   (succeed
                    (fresh (a d res)
                           (conso a d l)
                           (conso a res out)
                           (swappendo d s res)))
                   (else (nullo l) (== s out)))))


(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (run 1 (z)
       (fresh (x y)
              (swappendo x y z)))

  )
