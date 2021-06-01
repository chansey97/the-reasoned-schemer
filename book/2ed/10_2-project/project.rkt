#lang racket
(require "../10_1-impl/4-interface/walk_star.rkt")
(require "../appendix-impl/extended-syntax.rkt")
(provide (all-defined-out))

; 'project' is defined in the frame 10:98 on page 166.
(define-syntax project
  (syntax-rules ()
    ((project (x ...) g ...)
     (lambda (s)
       (let ((x (walk* x s)) ...)
         ((conj g ...) s))))))
