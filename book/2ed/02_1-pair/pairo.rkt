#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./conso.rkt")
(provide (all-defined-out))

;; 2.46
(defrel (pairo p)
  (fresh (a d)
         (conso a d p)))

