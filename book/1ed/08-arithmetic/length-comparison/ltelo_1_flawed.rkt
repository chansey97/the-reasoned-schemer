#lang racket
(require "../../libs/trs/mk.rkt")
(require "./eqlo.rkt")
(require "./ltlo.rkt")
(provide (all-defined-out))

; 8.38
(define <=lo
  (lambda (n m)
    (conde
     ((=lo n m) succeed)
     ((<lo n m) succeed)
     (else fail))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  (require "../mulo_2_correct.rkt")
  
  (test-check "8.39"
              (run 8 (t)
                   (fresh (n m)
                          (<=lo n m)
                          (== `(,n ,m) t)))
              `((() ())
                ((1) (1))
                ((_.0 1) (_.1 1))
                ((_.0 _.1 1) (_.2 _.3 1))
                ((_.0 _.1 _.2 1) (_.3 _.4 _.5 1))
                ((_.0 _.1 _.2 _.3 1) (_.4 _.5 _.6 _.7 1))
                ((_.0 _.1 _.2 _.3 _.4 1) (_.5 _.6 _.7 _.8 _.9 1))
                ((_.0 _.1 _.2 _.3 _.4 _.5 1) (_.6 _.7 _.8 _.9 _.10 _.11 1))))

  (test-check "8.40"
              (run 1 (t)
                   (fresh (n m)
                          (<=lo n m)
                          (*o n '(0 1) m)
                          (== `(,n ,m) t)))
              (list `(() ())))

  (test-divergence "8.41"
                   (run 2 (t)
                        (fresh (n m)
                               (<=lo n m)
                               (*o n '(0 1) m)
                               (== `(,n ,m) t))))

  (test-divergence "8-18"
                   (run 2 (t)
                        (fresh (n m)
                               (<=lo n m)
                               (*o n '(0 1) m)
                               (== `(,n ,m) t))))
  )

