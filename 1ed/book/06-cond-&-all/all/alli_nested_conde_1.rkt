#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")
(require "../anyo.rkt")
(require "../alwayso.rkt")
(require "../nevero.rkt")

(run 10 (q)
     (all
      (conde
       ((== 1 q) succeed)
       ((== 2 q) succeed)
       (else (== 3 q)))                    
      alwayso))
;; => '(1 1 1 1 1 1 1 1 1 1)

(run 10 (q)
     (alli
      (conde
       ((== 1 q) succeed)
       ((== 2 q) succeed)
       (else (== 3 q)))                    
      alwayso))
;; => '(1 2 1 3 1 2 1 3 1 2)

(define anyo-3
  (lambda-limited 3 (g)
                  (conde
                   (g succeed)
                   (else (anyo-3 g)))))

(define alwayso-3 (anyo-3 succeed))

(run 9 (q)
     (all
      (conde
       ((== 1 q) succeed)
       ((== 2 q) succeed)
       (else (== 3 q)))                    
      alwayso-3))
;; => '(1 1 1 2 2 2 3 3 3)

(run 9 (q)
     (alli
      (conde
       ((== 1 q) succeed)
       ((== 2 q) succeed)
       (else (== 3 q)))                    
      alwayso-3))
;; => '(1 2 1 3 1 2 3 2 3)

