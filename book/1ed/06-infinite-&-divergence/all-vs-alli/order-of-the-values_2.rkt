#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")
(require "../anyo.rkt")
(require "../alwayso.rkt")
(require "../nevero.rkt")

(run 10 (x)
     (fresh (p q)
            (all
             (conde
              ((== '1 p) succeed)
              (else (== '2 p)))
             (conde
              ((== 'a q) succeed)
              (else (== 'b q))))
            (== x `(,p ,q))))

;; =>  '((1 a) (1 b) (2 a) (2 b))

(run 10 (x)
     (fresh (p q)
            (alli
             (conde
              ((== '1 p) succeed)
              (else (== '2 p)))
             (conde
              ((== 'a q) succeed)
              (else (== 'b q))))
            (== x `(,p ,q))))

;; => '((1 a) (2 a) (1 b) (2 b))

;; ((1 a) (1 b)) mplusi ((2 a) (2 b))
;; = 
;; ((1 a) (2 a) (1 b) (2 b))

(run 10 (x)
     (fresh (o p q)
            (all
             (conde
              ((== 'A o) succeed)
              (else (== 'B o)))
             (conde
              ((== '1 p) succeed)
              (else (== '2 p)))
             (conde
              ((== 'a q) succeed)
              (else (== 'b q))))
            (== x `(,o ,p ,q))))

;; => '((A 1 a) (A 1 b) (A 2 a) (A 2 b) (B 1 a) (B 1 b) (B 2 a) (B 2 b))

(run 10 (x)
     (fresh (o p q)
            (alli
             (conde
              ((== 'A o) succeed)
              (else (== 'B o)))
             (conde
              ((== '1 p) succeed)
              (else (== '2 p)))
             (conde
              ((== 'a q) succeed)
              (else (== 'b q))))
            (== x `(,o ,p ,q))))

;; => '((A 1 a) (B 1 a) (A 2 a) (B 2 a) (A 1 b) (B 1 b) (A 2 b) (B 2 b))

;; The above is actually equivalent to the below: 
(run 10 (x)
     (fresh (o p q)
            (alli
             (conde
              ((== 'A o) succeed)
              (else (== 'B o)))
             (alli
              (conde
               ((== '1 p) succeed)
               (else (== '2 p)))
              (conde
               ((== 'a q) succeed)
               (else (== 'b q))))
             )
            (== x `(,o ,p ,q))))

;; A map cons to ((1 a) (2 a) (1 b) (2 b)) mplusi B map cons to ((1 a) (2 a) (1 b) (2 b))
;; '((A 1 a) (A 2 a) (A 1 b) (A 2 b)) mplusi ((B 1 a) (B 2 a) (B 1 b) (B 2 b))
;; =
;; '((A 1 a) (B 1 a) (A 2 a) (B 2 a) (A 1 b) (B 1 b) (A 2 b) (B 2 b))
