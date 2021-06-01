#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_1-pair/pairo.rkt")
(require "./nullo.rkt")
(provide (all-defined-out))

(define (singleton? l)
  (cond ((pair? l) (null? (cdr l)))
        (else #f)))

;; ;; 2.64
;; (defrel (singletono l)
;;   (conde
;;    ((pairo l)
;;     (fresh (d)
;;            (cdro l d)
;;            (nullo d)))
;;    (succeed fail)))

;; ;; 2.66, simplifed
;; (defrel (singletono l)
;;   (conde
;;    ((pairo l)
;;     (fresh (d)
;;            (cdro l d)
;;            (nullo d)))))

;; 2.68, more simplified
(defrel (singletono l)
  (fresh (d)
         (cdro l d)
         (nullo d)))
