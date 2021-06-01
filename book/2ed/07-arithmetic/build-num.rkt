#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 7.42
(define (build-num n)
  (cond
    ((zero? n) '())
    ((even? n)
     (cons 0
       (build-num (quotient n 2))))
    ((odd? n)
     (cons 1
       (build-num (quotient (- n 1) 2))))))

;; 7.43
;; (define (build-num n)
;;   (cond ((odd? n)
;;          (cons 1
;;            (build-num (quotient (- n 1) 2))))
;;         ((and (not (zero? n)) (even? n))
;;          (cons 0
;;            (build-num (quotient n 2))))
;;         ((zero? n) '())))
