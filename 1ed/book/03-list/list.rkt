#lang racket
(require "../libs/trs/mk.rkt")
(require "../02-pair/null.rkt")
(require "../02-pair/pair.rkt")
(require "../02-pair/cons.rkt")
(provide (all-defined-out))

; 3.1.1
(define list?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((pair? l) (list? (cdr l)))
      (else #f))))

; 3.5
(define listo
  (lambda (l)
    (conde
     ((nullo l) succeed)
     ((pairo l)
      (fresh (d)
             (cdro l d)
             (listo d)))
     (else fail))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "3.1.1"
              (list? `((a) (a b) c))
              #t)

  (test-check "3.2"
              (list? `())
              #t)

  (test-check "3.3"
              (list? 's)
              #f)

  (test-check "3.4"
              (list? `(d a t e . s))
              #f)

  (test-check "3.7"
              (run* (x)
                    (listo `(a b ,x d)))
              (list `_.0))

  (test-check "3.10"
              (run 1 (x)
                   (listo `(a b c . ,x)))
              (list `()))

  (test-divergence "3.13"
                   (run* (x)
                         (listo `(a b c . ,x))))

  (test-check "3.14"
              (run 5 (x)
                   (listo `(a b c . ,x)))
              `(()
                (_.0)
                (_.0 _.1)
                (_.0 _.1 _.2)
                (_.0 _.1 _.2 _.3)))
  
  )
