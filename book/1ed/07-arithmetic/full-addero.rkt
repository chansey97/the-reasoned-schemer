#lang racket
(require "../libs/trs/mk.rkt")
(provide (all-defined-out))

; 7.15.3
(define full-addero
  (lambda (b x y r c)
    (conde
     ((== 0 b) (== 0 x) (== 0 y) (== 0 r) (== 0 c))
     ((== 1 b) (== 0 x) (== 0 y) (== 1 r) (== 0 c))
     ((== 0 b) (== 1 x) (== 0 y) (== 1 r) (== 0 c))
     ((== 1 b) (== 1 x) (== 0 y) (== 0 r) (== 1 c))
     ((== 0 b) (== 0 x) (== 1 y) (== 1 r) (== 0 c))
     ((== 1 b) (== 0 x) (== 1 y) (== 0 r) (== 1 c))
     ((== 0 b) (== 1 x) (== 1 y) (== 0 r) (== 1 c))
     ((== 1 b) (== 1 x) (== 1 y) (== 1 r) (== 1 c))
     (else fail))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "7.16"
              (run* (s)
                    (fresh (r c)
                           (full-addero 1 1 1 r c)
                           (== `(,r ,c) s)))
              (list `(1 1)))

  (test-check "7.17"
              (run* (s)
                    (fresh (b x y r c)
                           (full-addero b x y r c)
                           (== `(,b ,x ,y ,r ,c) s)))
              `((0 0 0 0 0)
                (1 0 0 1 0)
                (0 1 0 1 0)
                (1 1 0 0 1)
                (0 0 1 1 0)
                (1 0 1 0 1)
                (0 1 1 0 1)
                (1 1 1 1 1)))
  )


