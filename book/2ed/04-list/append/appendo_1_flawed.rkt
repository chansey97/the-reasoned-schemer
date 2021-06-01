#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../02_2-list/nullo.rkt")

;; 4.1
(define (append l t)
  (cond ((null? l) t)
        (#t (cons (car l)
              (append (cdr l) t)))))

;; ;; 4.8
;; (defrel (appendo l t out)
;;   (conde
;;    ((nullo l) (== t out))
;;    ((fresh (res)
;;            (fresh (d)
;;                   (cdro l d)
;;                   (appendo d t res))
;;            (fresh (a)
;;                   (caro l a)
;;                   (conso a res out))))))

;; 4.13, simplified
(defrel (appendo l t out)
  (conde
   ((nullo l) (== t out))
   ((fresh (a d res)
           (conso a d l)
           (appendo d t res) ; recursive goal
           (conso a res out)))))

(module+ main
  (require "../../libs/test-harness.rkt")
  
  (test-divergence "4.39"
                   (run 7 (x y)
                        (appendo x y '(cake & ice d t))))

  )
