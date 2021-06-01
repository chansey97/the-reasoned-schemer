#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../02_1-pair/pairo.rkt")
(require "../append/appendo_2_correct.rkt")
(provide (all-defined-out))

; 5.58.1
(define flatten
  (lambda (s)
    (cond
      ((null? s) '())
      ((pair? s)
       (append
        (flatten (car s))
        (flatten (cdr s))))
      (else (cons s '())))))

; 5.59
(define flatteno
  (lambda (s out)
    (conde
     ((nullo s) (== '() out))
     ((pairo s)
      (fresh (a d res-a res-d)
             (conso a d s)
             (flatteno a res-a)
             (flatteno d res-d)
             (appendo res-a res-d out)))
     (else (conso s '() out)))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (test-check "5.58.1"
              (flatten '((a b) c))
              `(a b c))

  (test-check "5.60"
              (run 1 (x)
                   (flatteno '((a b) c) x))
              (list `(a b c)))

  (test-check "5.61"
              (run 1 (x)
                   (flatteno '(a (b c)) x))
              (list `(a b c)))

  (test-check "5.62"
              (run* (x)
                    (flatteno '(a) x))
              `((a)
                (a ())
                ((a))))

  (test-check "5.64"
              (run* (x)
                    (flatteno '((a)) x))
              `((a)
                (a ())
                (a ())
                (a () ())
                ((a))
                ((a) ())
                (((a)))))

  (test-check "5.66"
              (run* (x)
                    (flatteno '(((a))) x))
              `((a)
                (a ())
                (a ())
                (a () ())
                (a ())
                (a () ())
                (a () ())
                (a () () ())
                ((a))
                ((a) ())
                ((a) ())
                ((a) () ())
                (((a)))
                (((a)) ())
                ((((a))))))

  ; 5.68.1
  (define flattenogrumblequestion
    (lambda ()
      (run* (x)
            (flatteno '((a b) c) x)) ))

  ; 5.68.2
  (define flattenogrumbleanswer
    `((a b c)
      (a b c ())
      (a b (c))
      (a b () c)
      (a b () c ())
      (a b () (c))
      (a (b) c)
      (a (b) c ())
      (a (b) (c))
      ((a b) c)
      ((a b) c ())
      ((a b) (c))
      (((a b) c))))

  (test-check "flattenogrumble"
              (flattenogrumblequestion)
              flattenogrumbleanswer)

  (test-divergence "5.71"
                   (run* (x)
                         (flatteno x '(a b c))))


  (run* (q)
       (fresh (x y)
              (== `(,x . ,y) '(a b c d e f))
              (== q `(fst ,x snd ,y))))

  )

