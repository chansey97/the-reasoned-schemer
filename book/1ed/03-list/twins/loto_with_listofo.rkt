#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../listofo.rkt")
(require "./twinso_without-conso.rkt")
(provide (all-defined-out))

; lot stands for list-of-twins.

; 3.50
(define loto
  (lambda (l)
    (listofo twinso l)))
