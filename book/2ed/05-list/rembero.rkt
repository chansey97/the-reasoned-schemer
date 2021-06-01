#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_2-list/nullo.rkt")
(provide (all-defined-out))

;; 5.23
(define (rember x l)
  (cond ((null? l) '())
        ((equal? (car l) x)
         (cdr l))
        (#t (cons (car l)
              (rember x (cdr l))))))

;; 5.25
;; (defrel (rembero x l out)
;;   (conde
;;    ((nullo l) (== '() out))
;;    ((fresh (a)
;;            (caro l a)
;;            (== a x))
;;     (cdro l out))
;;    (succeed
;;     (fresh (res)
;;            (fresh (d)
;;                   (cdro l d)
;;                   (rembero x d res))
;;            (fresh (a)
;;                   (caro l a)
;;                   (conso a res out))))))

;; 5.25, simplified
(defrel (rembero x l out)
  (conde
   ((nullo l) (== '() out))
   ((conso x out l))
   ((fresh (a d res)
           (conso a d l)
           (conso a res out)
           (rembero x d res)))))

(module+ main

  ;; 5.26
  (run* out
        (rembero 'pea '(pea) out))
  ;; '(() (pea))

  ;; (run 5 (d res)
  ;;      (rembero 'pea d res))

  ;; (run* out
  ;;       (rembero 'pea '(x) '(x)))

  ;; 5.27
  (run* out
        (rembero 'pea
                 '(pea pea) out))
  ;; '((pea) (pea) (pea pea))

  ;; 5.28
  (run* out
        (fresh (y z)
               (rembero y
                        `(a b ,y d ,z e) out)))
  ;; '((b a d _0 e)
  ;;   (a b d _0 e)
  ;;   (a b d _0 e)
  ;;   (a b d _0 e)
  ;;   (a b _0 d e)
  ;;   (a b e d _0)
  ;;   (a b _0 d _1 e))

  ;; 5.48
  (run* (y z)
        (rembero y `(,y d ,z e) `(,y d e)))

  ;; 5.56
  (run 5 (y z w out)
       (rembero y `(,z . ,w) out))

  )
