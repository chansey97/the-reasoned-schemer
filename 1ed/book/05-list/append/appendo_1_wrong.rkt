#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(provide (all-defined-out))

; 5.2.1
(define append
  (lambda (l s)
    (cond
      ((null? l) s)
      (else (cons (car l)
              (append (cdr l) s))))))

;; ; 5.9
;; (define appendo
;;   (lambda (l s out)
;;     (conde
;;       ((nullo l) (== s out))
;;       (else 
;;         (fresh (a d res)
;;           (caro l a)
;;           (cdro l d)   
;;           (appendo d s res)
;;           (conso a res out))))))

;; use a single conso in place of the caro and cdro

; 5.15
(define appendo
  (lambda (l s out)
    (conde
     ((nullo l) (== s out))
     (else 
      (fresh (a d res)
             (conso a d l)
             (appendo d s res)
             (conso a res out))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "5.2.2"
              (append `(a b c) `(d e))
              `(a b c d e))

  (test-check "5.3"
              (append '(a b c) '())
              `(a b c))

  (test-check "5.4"
              (append '() '(d e))
              `(d e))

  (test-check "5.6"
              (append '(d e) 'a)
              `(d e . a))

  (test-check "5.10"
              (run* (x)
                    (appendo
                     '(cake)
                     '(tastes yummy)
                     x))
              (list `(cake tastes yummy)))

  (test-check "5.11"
              (run* (x)
                    (fresh (y)
                           (appendo
                            `(cake with ice ,y)
                            '(tastes yummy)
                            x)))
              (list `(cake with ice _.0 tastes yummy)))

  (test-check "5.12"
              (run* (x)
                    (fresh (y)
                           (appendo
                            '(cake with ice cream)
                            y
                            x)))
              (list `(cake with ice cream . _.0)))

  (test-check "5.13"
              (run 1 (x)
                   (fresh (y)
                          (appendo `(cake with ice . ,y) '(d t) x)))
              (list `(cake with ice d t)))

  (test-check "5.14"
              (run 1 (y)
                   (fresh (x)
                          (appendo `(cake with ice . ,y) '(d t) x)))
              (list '()))

  (test-check "5.16"
              (run 5 (x)
                   (fresh (y)
                          (appendo `(cake with ice . ,y) '(d t) x)))
              `((cake with ice d t)
                (cake with ice _.0 d t)
                (cake with ice _.0 _.1 d t)
                (cake with ice _.0 _.1 _.2 d t)
                (cake with ice _.0 _.1 _.2 _.3 d t)))

  (test-check "5.17"
              (run 5 (y)
                   (fresh (x)
                          (appendo `(cake with ice . ,y) '(d t) x)))
              `(()
                (_.0)
                (_.0 _.1)
                (_.0 _.1 _.2)
                (_.0 _.1 _.2 _.3)))

  (define y `(_.0 _.1 _.2)) 

  (test-check "5.18"
              `(cake with ice . ,y)
              `(cake with ice . (_.0 _.1 _.2)))

  (test-check "5.20"
              (run 5 (x)
                   (fresh (y)
                          (appendo
                           `(cake with ice . ,y)
                           `(d t . ,y)
                           x)))
              `((cake with ice d t)
                (cake with ice _.0 d t _.0)
                (cake with ice _.0 _.1 d t _.0 _.1)
                (cake with ice _.0 _.1 _.2 d t _.0 _.1 _.2)
                (cake with ice _.0 _.1 _.2 _.3 d t _.0 _.1 _.2 _.3)))

  (test-check "5.21"
              (run* (x)
                    (fresh (z)
                           (appendo
                            `(cake with ice cream)
                            `(d t . ,z)
                            x)))
              `((cake with ice cream d t . _.0)))

  (test-check "5.23"
              (run 6 (x)
                   (fresh (y)
                          (appendo x y `(cake with ice d t))))
              `(()
                (cake)
                (cake with)
                (cake with ice)
                (cake with ice d)
                (cake with ice d t)))

  (test-check "5.25"
              (run 6 (y)
                   (fresh (x)
                          (appendo x y `(cake with ice d t))))
              `((cake with ice d t)
                (with ice d t)
                (ice d t)
                (d t)
                (t)
                ()))

  ; 5.26.1
  (define appendxyquestion
    (lambda ()
      (run 6 (r)
           (fresh (x y)
                  (appendo x y `(cake with ice d t))
                  (== `(,x ,y) r)))))

  ; 5.26.2
  (define appendxyanswer
    `((() (cake with ice d t))
      ((cake) (with ice d t))
      ((cake with) (ice d t))
      ((cake with ice) (d t))
      ((cake with ice d) (t))
      ((cake with ice d t) ())))

  (test-check "appendxy"
              (appendxyquestion)
              appendxyanswer)

  (test-divergence "5.29"
                   (run 7 (r)
                        (fresh (x y)
                               (appendo x y `(cake with ice d t))
                               (== `(,x ,y) r))))
  )
