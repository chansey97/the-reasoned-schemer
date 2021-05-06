#lang racket
(require "./var.rkt")
(require "./substitution.rkt")
(require "./ext-s.rkt")
(require "./walk.rkt")
(provide (all-defined-out))

(define reify-name
  (lambda (n)
    (string->symbol
     (string-append "_" "." (number->string n)))))

;; Here is the definition of reify-s,
;; whose first argument is assumed to have been walk*ed (we know in which all variables must be fresh, see Frame 9:51),
;; whose second argument starts out as empty-s.
;; The result of an invocation of reify-s is called a reified-name substitution
(define reify-s
  (lambda (v s)
    (let ((v (walk v s)))
      (cond
        ((var? v) (ext-s v (reify-name (size-s s)) s))
        ((pair? v) (reify-s (cdr v) (reify-s (car v) s)))
        (else s)))))

(module+ main
  (require "../libs/test-harness.rkt")
  (require "./walk_star.rkt")

  ; 9.6
  (define u (var 'u)) 
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))
  
  ;; Frame 9:52
  ;; (reify-s v empty-s) returns a reified-name substitution
  ;; in which each variable in v is associated with its reified name.†
  (test-check "9.52"
              (reify-s `(a ,x ,y) empty-s)
              `((,y . _.1) (,x . _.0)))

  ;; first reify-s, then walk*,
  ;; we get the reified v that is a v in which every fresh variables be replace by a reified name.
  (test-check "9.53"
              (let ((r `(,w ,x ,y)))
                (walk* r (reify-s r empty-s)))
              `(_.0 _.1 _.2))

  (test-check "9.54"
              (let ((r (walk* `(,x ,y ,z) empty-s)))
                (walk* r (reify-s r empty-s)))
              `(_.0 _.1 _.2))

  (test-check "9.55"
              (let ((r `(,u (,v (,w ,x) ,y) ,x)))
                (walk* r (reify-s r empty-s)))
              `(_.0 (_.1 (_.2 _.3) _.4) _.3))

  (test-check "9.56"
              (let ((s `((,y . (,z ,w c ,w)) (,x . ,y) (,z . a))))
                (let ((r (walk* x s)))
                  (walk* r (reify-s r empty-s))))
              `(a _.0 c _.0))

  )


