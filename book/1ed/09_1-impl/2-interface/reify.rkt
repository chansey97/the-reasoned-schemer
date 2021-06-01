#lang racket
(require "../1-substitution/var.rkt")
(require "../1-substitution/common.rkt")
(require "../1-substitution/ext-s.rkt")
(require "./walk_star.rkt")
(require "./reify-s.rkt")
(provide (all-defined-out))

(define reify
  (lambda (v)
    (walk* v (reify-s v empty-s))))

(module+ main
  (require "../../libs/test-harness.rkt")

  ; 9.6
  (define u (var 'u)) 
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))

  ;; Use a wrapper procedure reify for (walk* v (reify-s v empty-s))
  (test-check "9.58"
              (let ((s `((,y . (,z ,w c ,w)) (,x . ,y) (,z . a))))
                (reify (walk* x s)))
              `(a _.0 c _.0))
  
  (test-check "(walk* x s) only"
              (let ((s `((,y . (,z ,w c ,w)) (,x . ,y) (,z . a))))
                (walk* x s))
              `(a ,w c ,w))

  )


