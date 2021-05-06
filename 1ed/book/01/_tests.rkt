#lang racket
(require "../libs/trs/mk.rkt")
(require "../libs/trs/mkextraforms.rkt")
(require "../libs/test-harness.rkt")

(test-check "1.10"
  (run* (q)
    fail)
  `())

(test-check "1.11"
  (run* (q)
    (== #t q))
  `(#t))

(test-check "1.12"
  (run* (q) 
    fail
    (== #t q))
  `())

(define g fail)

(test-check "1.13"
  (run* (q) 
    succeed 
    (== #t q))
  (list #t))

(test-check "1.14"
  (run* (q) 
    succeed 
    (== #t q))
  `(#t))

(test-check "1.15"
  (run* (r) 
    succeed
    (== 'corn r))
  (list 'corn))

(test-check "1.16"
  (run* (r) 
    succeed
    (== 'corn r))
  `(corn))

(test-check "1.17"
  (run* (r)
    fail
    (== 'corn r))
  `())

(test-check "1.18"
  (run* (q) 
    succeed 
    (== #f q))
  `(#f))

(test-check "1.22"
  (run* (x)
    (let ((x #f))
      (== #t x)))
  '())

(test-check "1.23"
  (run* (q)
    (fresh (x)
      (== #t x)
      (== #t q)))
  (list #t))

(test-check "1.26"
  (run* (q)
    (fresh (x)
      (== x #t)
      (== #t q)))
  (list #t))

(test-check "1.27"
  (run* (q)
    (fresh (x)
      (== x #t)
      (== q #t)))
  (list #t))

(test-check "1.28"
  (run* (x)
    succeed)
  (list `_.0))

(test-check "1.29"
  (run* (x)
    (let ((x #f))
      (fresh (x)
        (== #t x))))
  `(_.0))

(test-check "1.30"
  (run* (r)
    (fresh (x y)
      (== (cons x (cons y '())) r)))
  (list `(_.0 _.1)))

(test-check "1.31"
  (run* (s)
    (fresh (t u)
      (== (cons t (cons u '())) s)))
  (list `(_.0 _.1)))

(test-check "1.32"
  (run* (r)
    (fresh (x)
      (let ((y x))
        (fresh (x)
          (== (cons y (cons x (cons y '()))) r)))))
  (list `(_.0 _.1 _.0)))

(test-check "1.33"
  (run* (r)
    (fresh (x)
      (let ((y x))
        (fresh (x)
          (== (cons x (cons y (cons x '()))) r)))))
  (list `(_.0 _.1 _.0)))

(test-check "1.34"
  (run* (q) 
    (== #f q)
    (== #t q))
  `())

(test-check "1.35"
  (run* (q) 
    (== #f q)
    (== #f q))
  '(#f))

(test-check "1.36"
  (run* (q)
    (let ((x q))
      (== #t x)))
  (list #t))

(test-check "1.37"
  (run* (r)
    (fresh (x)
      (== x r)))
  (list `_.0))

(test-check "1.38"
  (run* (q)
    (fresh (x)
      (== #t x)
      (== x q)))
  (list #t))

(test-check "1.39"
  (run* (q)
    (fresh (x)
      (== x q)
      (== #t x)))
  (list #t))

(test-check "1.40.1"
  (run* (q)
    (fresh (x)
      (== (eq? x q) q)))
  (list #f))

(test-check "1.40.2"
  (run* (q)
    (let ((x q))
      (fresh (q)
        (== (eq? x q) x))))
  (list #f))

(test-check "1.41"
  (cond
    (#f #t)
    (else #f))
  #f)

(test-check "1.43"
  (cond
    (#f succeed)
    (else fail))
  fail)

(test-check "1.44"
  (run* (q)
    (conde 
      (fail succeed) 
      (else fail)))
  '())

(test-check "1.45"
  (not (null? (run* (q)
                (conde
                  (fail fail)
                  (else succeed)))))
  #t)

(test-check "1.46"
  (not (null? (run* (q)
                (conde
                  (succeed succeed)
                  (else fail)))))
  #t)
  

(test-check "1.47"
  (run* (x)
    (conde
      ((== 'olive x) succeed)
      ((== 'oil x) succeed)
      (else fail)))
  `(olive oil))

(test-check "1.49"
  (run 1 (x)
    (conde
      ((== 'olive x) succeed)
      ((== 'oil x) succeed)
      (else fail)))
  `(olive))

(test-check "1.50.1"
  (run* (x)
    (conde
      ((== 'virgin x) fail)
      ((== 'olive x) succeed)
      (succeed succeed)
      ((== 'oil x) succeed)
      (else fail)))
  `(olive _.0 oil))

(test-check "1.50.2"
  (run* (x)
    (conde
      ((== 'olive x) succeed)
      (succeed succeed)
      ((== 'oil x) succeed)
      (else fail)))
  `(olive _.0 oil))

(test-check "1.52"
  (run 2 (x)
    (conde
      ((== 'extra x) succeed)
      ((== 'virgin x) fail)
      ((== 'olive x) succeed)
      ((== 'oil x) succeed)  
      (else fail)))
  `(extra olive))

(test-check "1.53"
  (run* (r)
    (fresh (x y)
      (== 'split x)
      (== 'pea y)
      (== (cons x (cons y '())) r)))
  (list `(split pea)))

(test-check "1.54"
  (run* (r)
    (fresh (x y)
      (conde
        ((== 'split x) (== 'pea y))
        ((== 'navy x) (== 'bean y))
        (else fail))
      (== (cons x (cons y '())) r)))
  `((split pea) (navy bean)))

(test-check "1.55"
  (run* (r)
    (fresh (x y)
      (conde
        ((== 'split x) (== 'pea y))
        ((== 'navy x) (== 'bean y))
        (else fail))
      (== (cons x (cons y (cons 'soup '()))) r)))
  `((split pea soup) (navy bean soup)))

; 1.56
(define teacupo
  (lambda (x)
    (conde
      ((== 'tea x) succeed)
      ((== 'cup x) succeed)
      (else fail))))

(test-check "1.56"
  (run* (x)
    (teacupo x))
  `(tea cup))

(test-check "1.57"
  (run* (r)
    (fresh (x y)
      (conde
        ((teacupo x) (== #t y) succeed)
        ((== #f x) (== #t y))
        (else fail))
      (== (cons x (cons y '())) r)))
  `((tea #t) (cup #t) (#f #t)))

(test-check "1.58"
  (run* (r)
    (fresh (x y z)
      (conde
        ((== y x) (fresh (x) (== z x)))
        ((fresh (x) (== y x)) (== z x))
        (else fail))
      (== (cons y (cons z '())) r)))
  `((_.0 _.1) (_.0 _.1)))

(test-check "1.59"
  (run* (r)
    (fresh (x y z)
      (conde
	((== y x) (fresh (x) (== z x)))
	((fresh (x) (== y x)) (== z x))
	(else fail))
      (== #f x)
      (== (cons y (cons z '())) r)))
  `((#f _.0) (_.0 #f)))

(test-check "1.60"
  (run* (q)
    (let ((a (== #t q))
          (b (== #f q)))
      b))
  '(#f))

(test-check "1.61"
  (run* (q)
    (let ((a (== #t q))
          (b (fresh (x)
               (== x q)
               (== #f x)))
          (c (conde
               ((== #t q) succeed)
               (else (== #f q)))))
      b))
  '(#f))
