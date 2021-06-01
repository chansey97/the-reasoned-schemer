#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(require "../02_2-list/nullo.rkt")
(provide (all-defined-out))

;; 5.1
(define (mem x l)
  (cond ((null? l) #f)
        ((equal? (car l) x) l)
        (#t (mem x (cdr l)))))

;; ;; 5.4
;; (defrel (memo x l out)
;;   (conde
;;    ((nullo l) fail)
;;    ((fresh (a)
;;            (caro l a)
;;            (== a x))
;;     (== l out))
;;    (succeed (fresh (d)
;;               (cdro l d)
;;               (memo x d out)))))

;; 5.4, simplified
(defrel (memo x l out)
  (conde
   ((caro l x) (== l out))
   ((fresh (d)
           (cdro l d)
           (memo x d out)))))

(module+ main

  ;; 5.5
  (run* q
        (memo 'fig '(pea) '(pea)))

  ;; 5.19
  (run 5 (x y)
       (memo 'fig `(fig d fig e . ,y) x))

  ;; '(((fig d fig e . _0) _0)
  ;;   ((fig e . _0) _0)
  ;;   ((fig . _0) (fig . _0))
  ;;   ((fig . _0) (_1 fig . _0))
  ;;   ((fig . _0) (_1 _2 fig . _0)))

  )
