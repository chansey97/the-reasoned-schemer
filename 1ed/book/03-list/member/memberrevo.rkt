#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(require "./eq-caro.rkt")
(provide (all-defined-out))

;; swapped the second conde line with the third conde line of membero.

; 3.98
(define memberrevo
  (lambda (x l)
    (conde
     ((nullo l) fail)
     (succeed
      (fresh (d)
             (cdro l d)
             (memberrevo x d)))
     (else (eq-caro l x)))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "3.100"
              (run* (x) 
                    (memberrevo x `(pasta e fagioli)))
              `(fagioli e pasta))

  ; 3.101
  (define reverse-list
    (lambda (l)
      (run* (y)
            (memberrevo y l))))

  (test-check "3.101"
              (reverse-list '(1 2 3 4))
              `(4 3 2 1))
  
  )



