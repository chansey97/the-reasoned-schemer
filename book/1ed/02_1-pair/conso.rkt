#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

;; 2.9
(define caro
  (lambda (p a)
    (fresh (d)
           (== (cons a d) p))))

;; 2.16
(define cdro
  (lambda (p d)
    (fresh (a)
           (== (cons a d) p))))

;; 2.28
(define conso
  (lambda (a d p)
    (== (cons a d) p)))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "2.1"
              (let ((x (lambda (a) a))
                    (y 'c))
                (x y))
              'c)

  (test-check "2.2"
              (run* (r)
                    (fresh (y x)
                           (== `(,x ,y) r)))
              (list `(_.0 _.1)))

  (test-check "2.3"
              (run* (r)
                    (fresh (v w)
                           (== (let ((x v) (y w)) `(,x ,y)) r)))
              `((_.0 _.1)))

  (test-check "2.4"
              (car `(grape raisin pear))
              `grape)

  (test-check "2.5"
              (car `(a c o r n))
              'a)
  

  (test-check "2.6"
              (run* (r)
                    (caro `(a c o r n) r))
              (list 'a))

  (test-check "2.7"
              (run* (q) 
                    (caro `(a c o r n) 'a)
                    (== #t q))
              (list #t))

  (test-check "2.8"
              (run* (r)
                    (fresh (x y)
                           (caro `(,r ,y) x)
                           (== 'pear x)))
              (list 'pear))

  (test-check "2.10"
              (cons 
                  (car `(grape raisin pear))
                (car `((a) (b) (c))))
              `(grape a))

  (test-check "2.11"
              (run* (r)
                    (fresh (x y)
                           (caro `(grape raisin pear) x)
                           (caro `((a) (b) (c)) y)
                           (== (cons x y) r)))
              (list `(grape a)))

  (test-check "2.13"
              (cdr `(grape raisin pear))
              `(raisin pear))

  (test-check "2.14"
              (car (cdr `(a c o r n)))
              'c)


  (test-check "2.15"
              (run* (r)
                    (fresh (v)
                           (cdro `(a c o r n) v)
                           (caro v r)))
              (list 'c))

  (test-check "2.17"
              (cons 
                  (cdr `(grape raisin pear))
                (car `((a) (b) (c))))
              `((raisin pear) a))

  (test-check "2.18"
              (run* (r)
                    (fresh (x y)
                           (cdro `(grape raisin pear) x)
                           (caro `((a) (b) (c)) y)
                           (== (cons x y) r)))
              (list `((raisin pear) a)))

  (test-check "2.19.1"
              (run* (q) 
                    (cdro '(a c o r n) '(c o r n)) 
                    (== #t q))
              (list #t))

  (test-check "2.19.2"
              `(c o r n)
              (cdr '(a c o r n)))

  (test-check "2.20.1"
              (run* (x)
                    (cdro '(c o r n) `(,x r n)))
              (list 'o))

  (test-check "2.20.2"
              `(o r n) 
              (cdr `(c o r n)))

  (test-check "2.21"
              (run* (l)
                    (fresh (x) 
                           (cdro l '(c o r n))
                           (caro l x)
                           (== 'a x)))
              (list `(a c o r n)))


  (test-check "2.22"
              (run* (l)
                    (conso '(a b c) '(d e) l))
              (list `((a b c) d e)))

  (test-check "2.23.1"
              (run* (x)
                    (conso x '(a b c) '(d a b c)))
              (list 'd))

  (test-check "2.23.2"
              (cons 'd '(a b c))
              `(d a b c))

  (test-check "2.24"
              (run* (r)
                    (fresh (x y z)
                           (== `(e a d ,x) r)
                           (conso y `(a ,z c) r)))
              (list `(e a d c)))

  (test-check "2.25.1"
              (run* (x)
                    (conso x `(a ,x c) `(d a ,x c)))
              (list 'd))

  (define x 'd)

  (test-check "2.25.2"
              (cons x `(a ,x c))
              `(d a ,x c))

  (test-check "2.26"
              (run* (l)
                    (fresh (x)
                           (== `(d a ,x c) l)
                           (conso x `(a ,x c) l)))
              (list `(d a d c)))

  (test-check "2.27"
              (run* (l)
                    (fresh (x)
                           (conso x `(a ,x c) l)
                           (== `(d a ,x c) l)))
              (list `(d a d c)))

  (test-check "2.29"
              (run* (l)
                    (fresh (d x y w s)
                           (conso w '(a n s) s)
                           (cdro l s)
                           (caro l x)
                           (== 'b x)
                           (cdro l d)
                           (caro d y)
                           (== 'e y)))
              (list `(b e a n s)))
  )
