#lang racket
(require "./var.rkt")
(require "./walk.rkt")
(require "./ext-s.rkt")
(provide (all-defined-out))

;; 10.29
(define (unify u v s)
  (let ((u (walk u s))
        (v (walk v s)))
    (cond
      ((eqv? u v) s)
      ((var? u) (ext-s u v s))
      ((var? v) (ext-s v u s))
      ((and (pair? u) (pair? v))
       (let ((s (unify (car u) (car v) s)))
         (and s (unify (cdr u) (cdr v) s))))
      (else #f))))
