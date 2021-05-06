#lang racket
(provide (all-defined-out))

;; association
(define-syntax rhs
  (syntax-rules ()
    ((rhs p) (cdr p))))

(define-syntax lhs
  (syntax-rules ()
    ((lhs p) (car p))))

;; substitution, we represent a substitution by an assoc list
(define empty-s '())

(define-syntax size-s
  (syntax-rules ()
    ((size-s ls) (length ls))))

;; This is a substitution
;; ((,z . a) (,x . ,w) (,y . ,z))

;; This is not a substitution
;; ((,z . a) (,x . ,w) (,y . ,z))

(module+ main
  (require "../libs/test-harness.rkt")
  (require "./var.rkt")
  
  ; 9.6
  (define u (var 'u)) 
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))
  
  (test-check "9.8"
              (rhs `(,z . b))
              'b)

  (test-check "9.9"
              (rhs `(,z . ,w))
              w)

  (test-check "9.10"
              (rhs `(,z . (,x e ,y)))
              `(,x e ,y))
  )
