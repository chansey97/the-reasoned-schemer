#lang racket
(require "./var.rkt")
(require "./substitution.rkt")
(provide (all-defined-out))

(define walk
  (lambda (v s)
    (cond
      ((var? v)
       (cond
         ((assq v s) =>
                     (lambda (a)
                       (let ((v^ (rhs a)))
                         (walk v^ s))))
         (else v)))
      (else v))))

(module+ main
  (require "../libs/test-harness.rkt")
  
  ; 9.6
  (define u (var 'u)) 
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))

  (test-check "9.14"
              (walk z `((,z . a) (,x . ,w) (,y . ,z)))
              'a)

  (test-check "9.15"
              (walk y `((,z . a) (,x . ,w) (,y . ,z)))
              'a)

  (test-check "9.16"
              (walk x `((,z . a) (,x . ,w) (,y . ,z)))
              w)

  (test-check "9.17"
              (walk w `((,z . a) (,x . ,w) (,y . ,z)))
              w)

  (test-divergence "9.18"
                   (walk x `((,x . ,y) (,z . ,x) (,y . ,z))))
  ;; Note: If a substituion built by unify then (walk x s) always has a value

  (test-check "9.19"
              (walk w `((,x . ,y) (,w . b) (,z . ,x) (,y . ,z)))
              'b)

  (test-check "9.25"
              (walk u `((,x . b) (,w . (,x e ,x)) (,u . ,w)))
              `(,x e ,x))
  ;; Note: It isn't '(b e b)
  
  )
