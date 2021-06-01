#lang racket
(require "../../libs/trs/mk.rkt")
(provide (all-defined-out))

;; see https://youtu.be/fHK-uS-Iedc?list=PLUtmotlo8IA49dzssf5xgnGfc7dziSbNw 10:30

;; A naive =/= implementation
;; if unify success，let it fail
;; if unify fail, let it succeed (which means return original subst)
;; But this naive =/= has problem, see surpriso_not_fix.rkt
(define =/= 
  (lambda (v w)
    (lambdag@ (s)
              (cond
                ((unify v w s) => fail)
                (else (succeed s))))))

(define rembero  
  (lambda (x l out)
    (conde
     ((== '() l) (== '() out))
     ((fresh (d)
             (== `(,x . ,d) l)
             (== d out)))
     ((fresh (a d res)
             (== `(,a . ,d) l)
             (=/= a x)
             (== `(,a . ,res) out)
             (rembero x d res)
             )))))


(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  ;; Fix problem 1
  (run 1 (q) (rembero 'b '(a b c) q))
  ;; '((a c)) ; OK
  
  (run 2 (q) (rembero 'b '(a b c) q))
  ;; '((a c))
  )
