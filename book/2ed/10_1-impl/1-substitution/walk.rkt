#lang racket
(require "./var.rkt")
(provide (all-defined-out))

;; 10.18
(define (walk v s)
  (let ((a (and (var? v) (assv v s))))
    (cond ((pair? a) (walk (cdr a) s))
          (else v))))
