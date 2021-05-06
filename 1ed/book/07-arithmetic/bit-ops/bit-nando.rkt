#lang racket
(require "../../libs/trs/mk.rkt")
(provide (all-defined-out))

(define bit-nando
  (lambda (x y r)
    (conde
     ((== 0 x) (== 0 y) (== 1 r))
     ((== 1 x) (== 0 y) (== 1 r))
     ((== 0 x) (== 1 y) (== 1 r))
     ((== 1 x) (== 1 y) (== 0 r))
     (else fail))))

;; bit-nando is a universal binary boolean relation,
;; since it can be used to define all other binary boolean relations.

; 7.5
(define bit-xoro
  (lambda (x y r)
    (fresh (s t u)
           (bit-nando x y s)
           (bit-nando x s t)
           (bit-nando s y u)
           (bit-nando t u r))))

; 7.10
(define bit-noto
  (lambda (x r)
    (bit-nando x x r)))

(define bit-ando
  (lambda (x y r)
    (fresh (s)
           (bit-nando x y s)
           (bit-noto s r))))
