#lang racket
(require "../libs/trs/mk.rkt")
(require "./bit-ops/bit-xoro.rkt")
(require "./bit-ops/bit-ando.rkt")
(provide (all-defined-out))

; 7.12.1
(define half-addero
  (lambda (x y r c)
    (all
     (bit-xoro x y r)
     (bit-ando x y c))))

;; ; 7.12.2
;; (define half-addero
;;   (lambda (x y r c)
;;     (conde
;;      ((== 0 x) (== 0 y) (== 0 r) (== 0 c))
;;      ((== 1 x) (== 0 y) (== 1 r) (== 0 c))
;;      ((== 0 x) (== 1 y) (== 1 r) (== 0 c))
;;      ((== 1 x) (== 1 y) (== 0 r) (== 1 c))
;;      (else fail))))

; 7.15.1
(define full-addero
  (lambda (b x y r c)
    (fresh (w xy wz)
           (half-addero x y w xy)
           (half-addero w b r wz)
           (bit-xoro xy wz c))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")

  (test-check "7.12.2"
              (run* (r)
                    (half-addero 1 1 r 1))
              (list 0))

  (test-check "7.13"
              (run* (s)
                    (fresh (x y r c)
                           (half-addero x y r c)
                           (== `(,x ,y ,r ,c) s)))
              `((0 0 0 0)
                (1 0 1 0)
                (0 1 1 0)
                (1 1 0 1)))
  
  (test-check "7.15.2"
              (run* (s)
                    (fresh (r c)
                           (full-addero 0 1 1 r c)
                           (== `(,r ,c) s)))
              (list `(0 1)))
  )
