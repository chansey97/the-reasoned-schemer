#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./logo.rkt")
(provide (all-defined-out))

;; 8.93
(defrel (expo b q n)
  (logo n b q '()))
