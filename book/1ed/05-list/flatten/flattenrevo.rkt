#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../02_1-pair/pairo.rkt")
(require "../append/appendo_2_correct.rkt")
(provide (all-defined-out))

; 5.73
(define flattenrevo
  (lambda (s out)
    (conde
     (succeed (conso s '() out))
     ((nullo s) (== '() out))
     (else
      (fresh (a d res-a res-d)
             (conso a d s)
             (flattenrevo a res-a)
             (flattenrevo d res-d)
             (appendo res-a res-d out))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  ; 5.68.2
  (define flattenogrumbleanswer
    `((a b c)
      (a b c ())
      (a b (c))
      (a b () c)
      (a b () c ())
      (a b () (c))
      (a (b) c)
      (a (b) c ())
      (a (b) (c))
      ((a b) c)
      ((a b) c ())
      ((a b) (c))
      (((a b) c))))
  
  (test-check "5.75"
              (run* (x)
                    (flattenrevo '((a b) c) x))
              `((((a b) c))
                ((a b) (c))
                ((a b) c ())
                ((a b) c)
                (a (b) (c))
                (a (b) c ())
                (a (b) c)
                (a b () (c))
                (a b () c ())
                (a b () c)
                (a b (c))
                (a b c ())
                (a b c)))

  (test-check "5.76"
              (reverse
               (run* (x)
                     (flattenrevo '((a b) c) x)))
              flattenogrumbleanswer)

  (test-check "5.77"
              (run 2 (x)
                   (flattenrevo x '(a b c)))
              `((a b . c)
                (a b c)))

  (test-divergence "5.79"
                   (run 3 (x)
                        (flattenrevo x '(a b c))))

  (test-check "5.80"
              (length
               (run* (x)
                     (flattenrevo '((((a (((b))) c))) d) x)))
              574)
  )
