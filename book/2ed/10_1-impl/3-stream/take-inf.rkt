#lang racket
(provide (all-defined-out))

;; 10.74
(define (take-inf n s-inf)
  (cond
    ((and n (zero? n)) '())
    ((null? s-inf) '())
    ((pair? s-inf) 
     (cons (car s-inf)
       (take-inf (and n (sub1 n))
                 (cdr s-inf))))
    (else (take-inf n (s-inf)))))

(module+ main
  (require "../1-substitution/var.rkt")
  (require "../1-substitution/empty-s.rkt")
  (require "../2-goal-constructors/equality.rkt")
  (require "../2-goal-constructors/disj2.rkt")
  
  (define u (var 'u))
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))

  (let ((k (length
            (take-inf 5 ((disj2 (== 'olive x) (== 'oil x)) empty-s)))))
    `(Found ,k not 5 substitutions))
  )

