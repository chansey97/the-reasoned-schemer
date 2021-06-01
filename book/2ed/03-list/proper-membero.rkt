#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(require "./listo.rkt")
(provide (all-defined-out))

;; 3.75
(define (proper-member? x l)
  (cond ((null? l) #f)
        ((equal? (car l) x) (list? (cdr l)))
        (#t (proper-member? x (cdr l)))))

;; 3.73
(defrel (proper-membero x l)
  (conde
   ((caro l x)
    (fresh (d)
           (cdro l d)
           (listo d) ;关键行！
           ))
   ((fresh (d)
           (cdro l d)
           (proper-membero x d)))))

(module+ main
  
  (run 12 l
       ( proper-membero 'tofu l))

  ;; '((tofu)
  ;;   (tofu _0)
  ;;   (tofu _0 _1)
  ;;   (_0 tofu)
  ;;   (tofu _0 _1 _2)
  ;;   (tofu _0 _1 _2 _3)
  ;;   (_0 tofu _1)
  ;;   (tofu _0 _1 _2 _3 _4)
  ;;   (tofu _0 _1 _2 _3 _4 _5)
  ;;   (_0 tofu _1 _2)
  ;;   (tofu _0 _1 _2 _3 _4 _5 _6)
  ;;   (_0 _1 tofu))

  )
