#lang racket
(require "../libs/trs/mk.rkt")
(require "../libs/trs/mkextraforms.rkt")
(provide (all-defined-out))

;; 9.5
;; Prolog’s anonymous variable (see page 2 of William F. Clocksin. Clause and Effect.Springer, 1997.)
;; can be defined as an identifier macro that expands to (var (quote _)).

(define-syntax _
  (lambda (stx)
    (syntax-case stx ()
      [_ (identifier? (syntax _)) (syntax (var (quote _)))])))

