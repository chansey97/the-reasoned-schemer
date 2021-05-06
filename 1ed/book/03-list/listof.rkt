#lang racket
(require "../libs/trs/mk.rkt")
(require "../02-pair/null.rkt")
(require "../02-pair/cons.rkt")
(require "./list.rkt")
(provide (all-defined-out))

; 3.48
(define listofo
  (lambda (predo l)
    (conde
     ((nullo l) succeed)
     ((fresh (a)
             (caro l a)
             (predo a))
      (fresh (d)
             (cdro l d)
             (listofo predo d)))
     (else fail))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  (require "./twins/twinso_without-conso.rkt")
  
  (test-check "3.49"
              (run 3 (out)
                   (fresh (w x y z)
                          (== `((g g) (e ,w) (,x ,y) . ,z) out)
                          (listofo twinso out)))
              `(((g g) (e e) (_.0 _.0))
                ((g g) (e e) (_.0 _.0) (_.1 _.1))
                ((g g) (e e) (_.0 _.0) (_.1 _.1) (_.2 _.2))))

  )
