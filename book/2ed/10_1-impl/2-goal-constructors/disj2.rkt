#lang racket
(require "./append-inf.rkt")
(provide (all-defined-out))

;; 10.54
(define (disj2 g1 g2)
  (lambda (s)
    (append-inf (g1 s) (g2 s))))

(module+ main
  (require "../1-substitution/var.rkt")
  (require "../1-substitution/empty-s.rkt")
  (require "./equality.rkt")
  (require "./succeed-fail.rkt")
  
  (define u (var 'u))
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))

  ;; 10.61
  (define (nevero)
    (lambda (s)
      (lambda ()
        ((nevero) s))))


  ;; 10.63
  (let ((s∞ ((disj2
              (== 'olive x)
              (nevero))
             empty-s)))
    s∞)

  (let ((s∞ ((disj2
              (nevero)
              (== 'olive x))
             empty-s)))
    s∞)

  (define (alwayso)
    (lambda (s)
      (lambda ()
        ((disj2 succeed
                (alwayso)) s))))


  (let ((s∞ (((alwayso) empty-s))))
    (cons (car s∞) '()))

  )
