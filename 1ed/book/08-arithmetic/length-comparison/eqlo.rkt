#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../07-arithmetic/poso.rkt")
(provide (all-defined-out))

; 8.26
(define =lo
  (lambda (n m)
    (conde
     ((== '() n) (== '() m))
     ((== '(1) n) (== '(1) m))
     (else
      (fresh (a x b y)
             (== `(,a . ,x) n) (poso x)
             (== `(,b . ,y) m) (poso y)
             (=lo x y))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "8.27"
              (run* (t)
                    (fresh (w x y)
                           (=lo `(1 ,w ,x . ,y) '(0 1 1 0 1))
                           (== `(,w ,x ,y) t)))
              (list `(_.0 _.1 (_.2 1))))

  (test-check "8.28"
              (run* (b)
                    (=lo '(1) `(,b)))
              (list 1))

  (test-check "8.29"
              (run* (n)
                    (=lo `(1 0 1 . ,n) '(0 1 1 0 1)))
              (list `(_.0 1)))

  (test-check "8.30"
              (run 5 (t)
                   (fresh (y z)
                          (=lo `(1 . ,y) `(1 . ,z))
                          (== `(,y ,z) t)))
              `((() ())
                ((1) (1))
                ((_.0 1) (_.1 1))
                ((_.0 _.1 1) (_.2 _.3 1))
                ((_.0 _.1 _.2 1) (_.3 _.4 _.5 1))))

  (test-check "8.31"
              (run 5 (t)
                   (fresh (y z)
                          (=lo `(1 . ,y) `(0 . ,z))
                          (== `(,y ,z) t)))
              `(((1) (1))
                ((_.0 1) (_.1 1))
                ((_.0 _.1 1) (_.2 _.3 1))
                ((_.0 _.1 _.2 1) (_.3 _.4 _.5 1))
                ((_.0 _.1 _.2 _.3 1) (_.4 _.5 _.6 _.7 1))))

  (test-check "8.33"
              (run 5 (t)
                   (fresh (y z)
                          (=lo `(1 . ,y) `(0 1 1 0 1 . ,z))
                          (== `(,y ,z) t)))
              `(((_.0 _.1 _.2 1) ())
                ((_.0 _.1 _.2 _.3 1) (1))
                ((_.0 _.1 _.2 _.3 _.4 1) (_.5 1))
                ((_.0 _.1 _.2 _.3 _.4 _.5 1) (_.6 _.7 1))
                ((_.0 _.1 _.2 _.3 _.4 _.5 _.6 1) (_.7 _.8 _.9 1))))
  )

