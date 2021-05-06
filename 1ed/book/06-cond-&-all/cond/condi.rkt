#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")
(require "../anyo.rkt")
(require "../alwayso.rkt")
(require "../nevero.rkt")

(test-divergence "6.18"
                 (run 1 (q)                                                                  
                      (conde                                                                  
                       ((== #f q) alwayso)                                             
                       (else (anyo (== #t q))))                                             
                      (== #t q)))

(test-check "6.19"
            (run 1 (q)                                                                  
                 (condi                                                                  
                  ((== #f q) alwayso)                                              
                  (else (== #t q)))                                                      
                 (== #t q))
            `(#t))

(test-divergence "6.18"
                 (run 1 (q)                                                                  
                      (conde                                                                  
                       ((== #f q) alwayso)                                             
                       (else (anyo (== #t q))))                                             
                      (== #t q)))

(test-check "6.19"
            (run 1 (q)                                                                  
                 (condi                                                                  
                  ((== #f q) alwayso)                                              
                  (else (== #t q)))                                                      
                 (== #t q))
            `(#t))

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
