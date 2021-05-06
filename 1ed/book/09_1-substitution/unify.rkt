#lang racket
(require "./var.rkt")
(require "./ext-s.rkt")
(require "./walk.rkt")

(define unify
  (lambda (v w s)
    (let ((v (walk v s))
          (w (walk w s)))
      (cond
        ((eq? v w) s)
        ((var? v) (ext-s v w s))
        ((var? w) (ext-s w v s))
        ((and (pair? v) (pair? w))
         (cond
           ((unify (car v) (car w) s) =>
                                      (lambda (s)
                                        (unify (cdr v) (cdr w) s)))
           (else #f)))
        ((equal? v w) s)
        (else #f)))))

(module+ main
  (require "./substitution.rkt")
  
  ; 9.6
  (define u (var 'u)) 
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))
  
  (unify `(,x) `(,y) empty-s)
  ;; '((#(x) . #(y)))
  
  (unify `(,x) `(,z) empty-s)
  ;; '((#(x) . #(z)))
  
  (unify `(,x) `(,z) `((,x . ,y)))
  ;; '((#(y) . #(z)) (#(x) . #(y)))
  
  (unify `(,x ,x) `(,y ,z) empty-s)
  ;; '((#(y) . #(z)) (#(x) . #(y)))

  (unify `(1 ,x 2) x empty-s)
  ;; '((#(x) 1 #(x) 2))
  ;; = '((#(x) . (1 #(x) 2)))

  
  ;; Note:
  ;; unify can built circular substitution
  (unify `(,x) x empty-s)
  ;; '((#(x) #(x)))

  ;; but walk 
  (walk x (unify `(,x) x empty-s))

  ;; (require "./walk_star.rkt")
  ;; (walk* x (unify `(,x) x empty-s))
  ;; loop!
  )
