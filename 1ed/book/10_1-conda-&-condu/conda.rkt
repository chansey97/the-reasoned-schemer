#lang racket
(require "../libs/trs/mk.rkt")
(require "../libs/trs/mkextraforms.rkt")
(require "../libs/test-harness.rkt")

(test-check "10.1"
  (run* (q)
    (conda 
      (fail succeed) 
      (else fail)))
  '())

(test-check "10.2"
  (not (null? (run* (q)
                (conda
                  (fail succeed)
                  (else succeed)))))
  #t)

(test-check "10.3"
  (not (null? (run* (q)
                (conda
                  (succeed fail)
                  (else succeed)))))
  #f)

(test-check "10.4"
  (not (null? (run* (q)
                (conda
                  (succeed succeed)
                  (else fail)))))
  #t)

(test-check "10.5"
  (run* (x)
    (conda
      ((== 'olive x) succeed)
      ((== 'oil x) succeed)
      (else fail)))
  `(olive))

(test-check "10.7"
  (run* (x)
    (conda
      ((== 'virgin x) fail)
      ((== 'olive x) succeed)
      ((== 'oil x) succeed)
      (else fail)))
  `())

(test-check "10.8"
  (run* (q)
    (fresh (x y)
      (== 'split x)
      (== 'pea y)
      (conda
        ((== 'split x) (== x y))
        (else succeed)))
    (== #t q))
  `())

(test-check "10.9"
  (run* (q)
    (fresh (x y)
      (== 'split x)
      (== 'pea y)
      (conda
        ((== x y) (== 'split x))
        (else succeed)))
    (== #t q))
  (list #t))

;; The Third Commandment
;; If prior to determining the question of a conda line a variable is fresh, it must remain fresh in the question of that line.

; 10.11.1
(define not-pastao
  (lambda (x)
    (conda
      ((== 'pasta x) fail)
      (else succeed))))

(test-check "10.11.2"
  (run* (x) 
    (conda
      ((not-pastao x) fail)
      (else (== 'spaghetti x))))
  '(spaghetti))

(test-check "10.12"
  (run* (x)
    (== 'spaghetti x)  
    (conda
      ((not-pastao x) fail)
      (else (== 'spaghetti x))))
  '())
