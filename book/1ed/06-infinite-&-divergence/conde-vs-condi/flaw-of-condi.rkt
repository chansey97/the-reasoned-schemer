#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")
(require "../nevero.rkt")

;; condi的弱点，condi尽管会交错，但是顺序敏感!
;; 如果第一个clause 发散，则第二个不会被切换
;; 这个问题在2ed里增加解决

(run 1 (q)
     (condi                                                                  
      (nevero)                                              
      (else (== #t q)))                                                      
     (== #t q))

;; (run 1 (q)
;;      (condi                                                                  
;;       ((== #t q))                                               
;;       (else nevero))                                                      
;;      (== #t q))
