#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./teacupo.rkt")

;; 1.84
(run* (x y)
      (disj2
       (conj2 (teacupo x) (== #t y))
       (conj2 (== #f x) (== #t y))))

;; '((#f #t) (tea #t) (cup #t))
