#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(require "./eq-caro.rkt")
(provide (all-defined-out))

; 3.51.1
(define member?
  (lambda (x l)
    (cond
      ((null? l) #f)
      ((eq-car? l x) #t)
      (else (member? x (cdr l))))))

; 3.54.2
(define membero
  (lambda (x l)
    (conde
     ((nullo l) fail)
     ((eq-caro l x) succeed)
     (else
      (fresh (d)
             (cdro l d)
             (membero x d))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  ; 3.53
  (test-check "3-21"
              (member? 'olive `(virgin olive oil))
              #t)

  (test-check "3.57"
              (run* (q) 
                    (membero 'olive `(virgin olive oil))
                    (== #t q))
              (list #t))

  (test-check "3.58"
              (run 1 (y) 
                   (membero y `(hummus with pita)))
              (list `hummus))

  (test-check "3.59"
              (run 1 (y) 
                   (membero y `(with pita)))
              (list `with))

  (test-check "3.60"
              (run 1 (y) 
                   (membero y `(pita)))
              (list `pita))

  (test-check "3.61"
              (run* (y) 
                    (membero y `()))
              `())

  (test-check "3.62"
              (run* (y) 
                    (membero y `(hummus with pita)))
              `(hummus with pita))

  (test-check "3.64"
              (run* (y) 
                    (membero y `(hummus with pita)))
              `(hummus with pita))

  ;; Note that this identity only works for list
  
  ; 3.65
  (define identity
    (lambda (l)
      (run* (y)
            (membero y l))))

  (test-check "3.66"
              (run* (x) 
                    (membero 'e `(pasta ,x fagioli)))
              (list `e))

  (test-check "3.69"
              (run 1 (x) 
                   (membero 'e `(pasta e ,x fagioli)))
              (list `_.0))

  (test-check "3.70"
              (run 1 (x) 
                   (membero 'e `(pasta ,x e fagioli)))
              (list `e))

  (test-check "3.71"
              (run* (r)
                    (fresh (x y)
                           (membero 'e `(pasta ,x fagioli ,y))
                           (== `(,x ,y) r)))
              `((e _.0) (_.0 e)))

  (test-check "3.73"
              (run 1 (l) 
                   (membero 'tofu l))
              `((tofu . _.0)))

  (test-divergence "3.75"
                   (run* (l) 
                         (membero 'tofu l)))

  (test-check "3.76"
              (run 5 (l)
                   (membero 'tofu l))
              `((tofu . _.0)
                (_.0 tofu . _.1)
                (_.0 _.1 tofu . _.2)
                (_.0 _.1 _.2 tofu . _.3)
                (_.0 _.1 _.2 _.3 tofu . _.4)))

  )




