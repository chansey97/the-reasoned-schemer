#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../02_2-list/nullo.rkt")
(require "./twinso_without-conso.rkt")
(provide (all-defined-out))

; lot stands for list-of-twins.

; 3.37
(define loto
  (lambda (l)
    (conde
     ((nullo l) succeed)
     ((fresh (a)
             (caro l a)
             (twinso a))
      (fresh (d)
             (cdro l d)
             (loto d)))
     (else fail))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "3.38"
              (run 1 (z)
                   (loto `((g g) . ,z)))
              (list `()))

  (test-check "3.42"
              (run 5 (z)
                   (loto `((g g) . ,z)))
              '(()
                ((_.0 _.0))
                ((_.0 _.0) (_.1 _.1))
                ((_.0 _.0) (_.1 _.1) (_.2 _.2))
                ((_.0 _.0) (_.1 _.1) (_.2 _.2) (_.3 _.3))))

  (test-check "3.45"
              (run 5 (r)
                   (fresh (w x y z)
                          (loto `((g g) (e ,w) (,x ,y) . ,z))
                          (== `(,w (,x ,y) ,z) r)))
              '((e (_.0 _.0) ())
                (e (_.0 _.0) ((_.1 _.1)))
                (e (_.0 _.0) ((_.1 _.1) (_.2 _.2)))
                (e (_.0 _.0) ((_.1 _.1) (_.2 _.2) (_.3 _.3)))
                (e (_.0 _.0) ((_.1 _.1) (_.2 _.2) (_.3 _.3) (_.4 _.4)))))

  (test-check "3.47"
              (run 3 (out)
                   (fresh (w x y z)
                          (== `((g g) (e ,w) (,x ,y) . ,z) out)
                          (loto out)))
              `(((g g) (e e) (_.0 _.0))
                ((g g) (e e) (_.0 _.0) (_.1 _.1))
                ((g g) (e e) (_.0 _.0) (_.1 _.1) (_.2 _.2))))
  )
