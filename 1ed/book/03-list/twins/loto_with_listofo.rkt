#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/cons.rkt")
(require "../../02-pair/null.rkt")
(require "../listof.rkt")
(require "./twinso_without-conso.rkt")
(provide (all-defined-out))

; lot stands for list-of-twins.

; 3.50
(define loto
  (lambda (l)
    (listofo twinso l)))
