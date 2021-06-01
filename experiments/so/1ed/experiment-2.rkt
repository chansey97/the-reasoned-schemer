#lang racket
(require "../../../book/1ed/libs/trs/mk.rkt")
(require "../../../book/1ed/libs/trs/mkextraforms.rkt")

;; 2.9
(define caro
  (lambda (p a)
    (fresh (d)
           (== (cons a d) p))))

;; 2.16
(define cdro
  (lambda (p d)
    (fresh (a)
           (== (cons a d) p))))

;; 2.28
(define conso
  (lambda (a d p)
    (== (cons a d) p)))
	
;; 2.53
(define pairo
  (lambda (p)
    (fresh (a d)
           (conso a d p))))

;; 2.35
(define nullo
  (lambda (x)
    (== '() x)))

;; 3.5
(define listo
  (lambda (l)
    (conde
     ((nullo l) succeed)
     ((pairo l)
      (fresh (d)
             (cdro l d)
             (listo d)))
     (else fail))))

;; debugging
;; (define listo
;;   (lambda (l)
;;     (conde
;;      ((nullo l) (begin (printf "listo null\n") succeed))
;;      ((pairo l)
;;       (begin (printf "listo pairo\n") ; nerver tried!
;;              (fresh (d)
;;                (cdro l d)
;;                (listo d))))
;;      (else fail))))

;; 3.17
(define lolo
  (lambda (l)
    (conde
     ((nullo l) succeed)
     ((fresh (a) 
             (caro l a)
             (listo a))
      (fresh (d)
             (cdro l d)
             (lolo d)))
     (else fail))))
     
(run 5 (x)
     (lolo x))

;; => '(() (()) (() ()) (() () ()) (() () () ()))
