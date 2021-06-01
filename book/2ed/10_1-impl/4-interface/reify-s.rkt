#lang racket
(require "../1-substitution/var.rkt")
(require "../1-substitution/empty-s.rkt")
(require "../1-substitution/walk.rkt")
(provide (all-defined-out))

;; 10.93
(define (reify-name n)
  (string->symbol
   (string-append "_"
                  (number->string n))))

;; 10.104
(define (reify-s v r)
  (let ((v (walk v r)))
    (cond
      ((var? v)
       (let ((n (length r)))
         (let ((rn (reify-name n)))
           (cons `(,v . ,rn) r))))
      ((pair? v)
       (let ((r (reify-s (car v) r)))
         (reify-s (cdr v) r)))
      (else r))))

(module+ main

  (define u (var 'u))
  (define v (var 'v))
  (define w (var 'w))
  (define x (var 'x))
  (define y (var 'y))
  (define z (var 'z))

  ;; reified name substitution
  ;; `((,z . _2 ) (,y . _1) (,x . _0))

  ;; 注意：
  ;; (reify-s v empty-s)
  ;; reify-s的初始参数必须是空的subst，第一个参数必须是被walk*ed，也就是说第一个参数里假定变量都是fresh的
  ;; 尽管这些约束无法体现在reify的参数里
  ;; reify-s的目的是根据v里的变量生成出一个reified name substitution
  ;; 也就是把v里的所有变量全部变成`((,z . _2 ) (,y . _1) (,x . _0))这样的东西
  (reify-s `(99 123 ,x) empty-s)


  )
