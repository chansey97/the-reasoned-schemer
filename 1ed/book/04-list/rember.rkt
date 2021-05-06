#lang racket
(require "../libs/trs/mk.rkt")
(require "../02-pair/null.rkt")
(require "../02-pair/cons.rkt")
(require "../03-list/member/eq-caro.rkt")
(provide (all-defined-out))

; 4.22
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

;; we use cons o in place of the caro and the cdro

; 4.27
(define rembero  
  (lambda (x l out)
    (conde
     ((nullo l) (== '() out))
     ((eq-caro l x) (cdro l out))
     (else (fresh (a d res)
                  (conso a d l)
                  (rembero x d res)
                  (conso a res out))))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
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
