#lang racket
(require "../libs/trs/mk.rkt")
(require "../07-arithmetic/poso.rkt")
(require "../07-arithmetic/addo.rkt")
(require "../07-arithmetic/subo.rkt")
(require "./mulo_1_correct.rkt")
(require "./length-comparison/eqlo.rkt")
(require "./length-comparison/ltlo.rkt")
(require "./length-comparison/ltelo_2_correct.rkt")
(require "./comparison/lto.rkt")
(require "./splito.rkt")
(provide (all-defined-out))

; 8.76.1
(define /o
  (lambda (n m q r)
    (condi
     ((== r n) (== '() q) (<o n m))
     ((== '(1) q) (=lo n m) (+o r m n)
                  (<o r m))
     (else
      (alli
       (<lo m n)                        
       (<o r m)                        
       (poso q)                 
       (fresh (nh nl qh ql qlm qlmr rr rh)
              (alli
               (splito n r nl nh)
               (splito q r ql qh)
               (conde
                ((== '() nh)
                 (== '() qh)
                 (-o nl r qlm)
                 (*o ql m qlm))
                (else
                 (alli 
                  (poso nh)
                  (*o ql m qlm)
                  (+o qlm r qlmr)
                  (-o qlmr nl rr)
                  (splito rr r '() rh)
                  (/o nh m qh rh)))))))))))


(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "8.53"
              (run 15 (t)
                   (fresh (n m q r)
                          (/o n m q r)
                          (== `(,n ,m ,q ,r) t)))
              `((() (_.0 . _.1) () ())
                ((1) (1) (1) ())
                ((0 1) (1 1) () (0 1))
                ((0 1) (1) (0 1) ())
                ((1) (_.0 _.1 . _.2) () (1))
                ((_.0 1) (_.0 1) (1) ())
                ((0 _.0 1) (1 _.0 1) () (0 _.0 1))
                ((0 _.0 1) (_.0 1) (0 1) ())
                ((_.0 1) (_.1 _.2 _.3 . _.4) () (_.0 1))
                ((1 1) (0 1) (1) (1))
                ((0 0 1) (0 1 1) () (0 0 1))
                ((1 1) (1) (1 1) ())
                ((_.0 _.1 1) (_.2 _.3 _.4 _.5 . _.6) () (_.0 _.1 1))
                ((_.0 _.1 1) (_.0 _.1 1) (1) ())
                ((1 0 1) (0 1 1) () (1 0 1))))
  )


