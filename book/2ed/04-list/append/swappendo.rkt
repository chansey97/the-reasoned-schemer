#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../02_2-list/nullo.rkt")
(provide (all-defined-out))

;; The Law of Swapping conde Lines
;; Swapping two conde lines does not affect the values contributed by conde

;; 4.43
(defrel (swappendo l s out)
  (conde
   (succeed
    (fresh (a d res)
           (conso a d l)
           (conso a res out)
           (swappendo d s res)))
   ((nullo l) (== s out))))

(module+ main

  (run 5 (z)
       (fresh (x y)
              (swappendo x y z)))

  ;; 4.44
  (run* (x y)
        (swappendo x y '(cake & ice d t)))

  )
