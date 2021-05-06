#lang racket
(require "./var.rkt")
(require "./walk.rkt")
(provide (all-defined-out))

(define walk*
  (lambda (v s)
    (let ((v (walk v s)))
      (cond
        ((var? v) v)
        ((pair? v)
         (cons
             (walk* (car v) s)
           (walk* (cdr v) s)))
        (else v)))))

(module+ main
  (require "../libs/test-harness.rkt")
  
  ; 9.6
  (define u (var 'u)) 
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))

  (test-check "9.44"
              (walk* x `((,y . (a ,z c)) (,x . ,y) (,z . a)))
              `(a a c))

  (test-check "9.45"
              (walk* x `((,y . (,z ,w c)) (,x . ,y) (,z . a)))
              `(a ,w c))

  (test-check "9.46"
              (walk* y `((,y . (,w ,z c)) (,v . b) (,x . ,v) (,z . ,x)))
              `(,w b c))
  
  ;; Frame 9:51
  ;; What property holds with a value that has been walk*ed?
  ;; We know that any variable that appears in the resultant value must be fresh.
  )
