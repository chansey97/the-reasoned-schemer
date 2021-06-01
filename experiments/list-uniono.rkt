
;; 1ed

#lang racket
(require "../book/libs/trs/mk.rkt")
(require "../book/libs/trs/mkextraforms.rkt")
(provide (all-defined-out))

(define =/= 
  (lambda (v w)
    (lambdag@ (s)
              (cond
                ((unify v w s) => fail)
                (else (succeed s))))))


(define (member?o x ls out)
  (conde
   ((== '() ls) (== #f out))
   ((fresh (a d)
           (== `(,a . ,d) ls)
           (conde
            ((== x a) (== #t out))
            ((=/= x a) (member?o x d out)))))))

(define (list-uniono s1 s2 out)
  (conde
   ((== '() s1) (== s2 out))
   ((fresh (a d)
           (== `(,a . ,d) s1)
           (fresh (b res)
                  (conde
                   ((== b #t) (== res out))
                   ((== b #f) (== `(,a . ,res) out)))
                  (member?o a s2 b)
                  (list-uniono d s2 res))))))

(run 5 (q) (fresh (a b) (== q `(,a ,b)) (list-uniono a b '(1 2))))
(run 10 (q) (fresh (a b) (== q `(,a ,b)) (list-uniono a b '(1 2))))

(run 5 (q) (fresh (a b) (== q `(,a ,b)) (list-uniono a b '(1 2 3 4))))

