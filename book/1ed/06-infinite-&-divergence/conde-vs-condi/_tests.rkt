#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")
(require "../anyo.rkt")
(require "../alwayso.rkt")
(require "../nevero.rkt")

;; conde has no value
(test-divergence "6.18"
                 (run 1 (q)                                                                  
                      (conde                                                                  
                       ((== #f q) alwayso)                                             
                       (else (anyo (== #t q))))                                             
                      (== #t q)))

;; condi has value
(test-check "6.19"
            (run 1 (q)                                                                  
                 (condi                                                                  
                  ((== #f q) alwayso)                                              
                  (else (== #t q)))                                                      
                 (== #t q))
            `(#t))

;; conde has no value
(test-divergence "6.18"
                 (run 1 (q)                                                                  
                      (conde                                                                  
                       ((== #f q) alwayso)                                             
                       (else (anyo (== #t q))))                                             
                      (== #t q)))

;; condi has value
(test-check "6.19"
            (run 1 (q)                                                                  
                 (condi                                                                  
                  ((== #f q) alwayso)                                              
                  (else (== #t q)))                                                      
                 (== #t q))
            `(#t))

;; condi has no value
(test-divergence "6.20"
                 (run 2 (q)
                      (condi                                                                  
                       ((== #f q) alwayso)                                              
                       (else (== #t q)))                                                     
                      (== #t q)))

(test-check "6.21"
            (run 5 (q)
                 (condi                                                                  
                  ((== #f q) alwayso)                                              
                  (else (anyo (== #t q)))) 
                 (== #t q))
            `(#t #t #t #t #t))

; 1.56
(define teacupo
  (lambda (x)
    (conde
     ((== 'tea x) succeed)
     ((== 'cup x) succeed)
     (else fail))))

(test-check "6.24"
            (run 5 (r)
                 (condi
                  ((teacupo r) succeed)
                  ((== #f r) succeed)
                  (else fail)))
            `(tea #f cup))

;; condi has values
(test-check "6.25"
            (run 5 (q)
                 (condi
                  ((== #f q) alwayso)
                  ((== #t q) alwayso)
                  (else fail))
                 (== #t q))
            `(#t #t #t #t #t))

;; conde has no value
(test-divergence "6.27"
                 (run 5 (q)
                      (conde
                       ((== #f q) alwayso)
                       ((== #t q) alwayso)
                       (else fail))
                      (== #t q)))

;; conde has values
(test-check "6.28"
            (run 5 (q)                                                                  
                 (conde                                                                     
                  (alwayso succeed)
                  (else nevero))
                 (== #t q))
            `(#t #t #t #t #t))

;; condi has no value
(test-divergence "6.30"
                 (run 5 (q)                                                                  
                      (condi                                                                 
                       (alwayso succeed)
                       (else nevero))
                      (== #t q)))

;; all has no value, 这个问题在2ed里是没的
(test-divergence "6.31"
  (run 1 (q)                                                                  
    (all
      (conde
        ((== #f q) succeed)
        (else (== #t q)))                    
      alwayso)
    (== #t q)))
