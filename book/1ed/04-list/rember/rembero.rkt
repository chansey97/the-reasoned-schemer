#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02_2-list/nullo.rkt")
(require "../../02_1-pair/conso.rkt")
(require "../../03-list/member/eq-caro.rkt")
(provide (all-defined-out))

; 4.22
;; if l has x, remove first x from l
;; if l has no x, keep l
(define rember
  (lambda (x l)
    (cond
      ((null? l) '())
      ((eq-car? l x) (cdr l))
      (else 
       (cons (car l)
         (rember x (cdr l)))))))

;; ; 4.24
;; (define rembero
;;   (lambda (x l out)
;;     (conde
;;       ((nullo l) (== '() out))
;;       ((eq-caro l x) (cdro l out))
;;       (else
;;         (fresh (res)
;;           (fresh (d)
;;             (cdro l d)
;;             (rembero x d res))
;;           (fresh (a)
;;             (caro l a)
;;             (conso a res out)))))))

; 4.27, simplified by using conso in place of the caro and the cdro
(define rembero  
  (lambda (x l out)
    (conde
     ((nullo l) (== '() out))
     ((eq-caro l x) (cdro l out))
     (else (fresh (a d res)
                  (conso a d l)
                  (rembero x d res)
                  (conso a res out))))))


;; Note:
;; There are two problems in the `rembero` definition:
;; 1. The 2nd and 3rd line of conde are overlapping.
;; 2. The recursive relation call `(rembero x d res)` has not sink to the bottom.
;; More details, see rember_dan

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "4.23"
              (rember 'peas '(a b peas d peas e))
              `(a b d peas e))

  (test-check "4.30"
              (run 1 (out)
                   (fresh (y)
                          (rembero 'peas `(a b ,y d peas e) out)))
              `((a b d peas e)))

  (test-check "4.31"
              (run* (out)
                    (fresh (y z)
                           (rembero y `(a b ,y d ,z e) out)))
              `((b a d _.0 e)
                (a b d _.0 e)
                (a b d _.0 e)
                (a b d _.0 e)
                (a b _.0 d e)
                (a b e d _.0)
                (a b _.0 d _.1 e)))

  (test-check "4.49"
              (run* (r) 
                    (fresh (y z) 
                           (rembero y `(,y d ,z e) `(,y d e))
                           (== `(,y ,z) r)))
              `((d d)
                (d d)
                (_.0 _.0)
                (e e)))

  (test-check "4.57"
              (run 13 (w)
                   (fresh (y z out)
                          (rembero y `(a b ,y d ,z . ,w) out)))
              `(_.0 
                _.0
                _.0
                _.0
                _.0
                ()
                (_.0 . _.1)
                (_.0)
                (_.0 _.1 . _.2)
                (_.0 _.1)
                (_.0 _.1 _.2 . _.3)
                (_.0 _.1 _.2)
                (_.0 _.1 _.2 _.3 . _.4)))
  
  )
