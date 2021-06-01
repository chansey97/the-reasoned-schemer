#lang racket
(require "../1-substitution/var.rkt")
(require "../1-substitution/walk.rkt")
(provide (all-defined-out))

;; 10.98
(define (walk* v s)
  (let ((v (walk v s)))
    (cond
      ((var? v) v)
      ((pair? v)
       (cons
           (walk* (car v) s)
         (walk* (cdr v) s)))
      (else v))))
