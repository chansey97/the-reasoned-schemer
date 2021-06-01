#lang racket
(require "../../../book/2ed/libs/trs2/trs2-impl.rkt")

;; 2.6
(defrel (caro p a)
  (fresh (d)
         (== (cons a d) p)))

;; 2.13
(defrel (cdro p d)
  (fresh (a)
         (== (cons a d) p)))

;; 2.46
(defrel (pairo p)
  (fresh (a d)
         (conso a d p)))

(defrel (conso a d p)
  (== `(,a . ,d) p))

;; 2.33
(defrel (nullo x)
  (== '() x))


;; 3.8
(defrel (listo l)
  (conde
   ((nullo l))
   ((fresh (d)
           (cdro l d)
           (listo d)))))

;; 3.22
(defrel (lolo l)
  (conde
   ((nullo l))
   ((fresh (a)
           (caro l a)
           (listo a))
    (fresh (d)
           (cdro l d)
           (lolo d)))))

(run 5 x
     (lolo x))
;; => '(() (()) ((_0)) (() ()) ((_0 _1)))
