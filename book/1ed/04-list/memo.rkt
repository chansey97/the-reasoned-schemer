#lang racket
(require "../libs/trs/mk.rkt")
(require "../02_2-list/nullo.rkt")
(require "../02_1-pair/conso.rkt")
(require "../03-list/member/eq-caro.rkt")
(provide (all-defined-out))

; 4.1.1
;; if l has a x, return a sub-list which start from x
;; if l has no x, return #f
(define mem
  (lambda (x l)
    (cond
      ((null? l) #f)
      ((eq-car? l x) l)
      (else (mem x (cdr l))))))

;; ; 4.7
;; (define memo
;;   (lambda (x l out)
;;     (conde
;;      ((nullo l) fail) ;  always fails line
;;      ((eq-caro l x) (== l out))
;;      (else 
;;       (fresh (d)
;;              (cdro l d)
;;              (memo x d out))))))

; 4.21,  simplified by remove always fails line
(define memo
  (lambda (x l out)
    (conde
      ((eq-caro l x) (== l out))
      (else ; not perserving non-overlapping property, see "4.10 *"
        (fresh (d)
          (cdro l d)
          (memo x d out))))))


(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")

  (test-check "4.1.2"
              (mem 'tofu `(a b tofu d peas e))
              `(tofu d peas e))

  (test-check "4.2"
              (mem 'tofu `(a b peas d peas e))
              #f)

  (test-check "4.3"
              (run* (out) 
                    (== (mem 'tofu `(a b tofu d peas e)) out))
              (list `(tofu d peas e)))

  (test-check "4.4"
              (mem 'peas (mem 'tofu `(a b tofu d peas e)))
              `(peas e))

  (test-check "4.5"
              (mem 'tofu (mem 'tofu `(a b tofu d tofu e)))
              `(tofu d tofu e))

  (test-check "4.6"
              (mem 'tofu (cdr (mem 'tofu `(a b tofu d tofu e))))
              `(tofu e))



  (test-check "4.10"
              (run 1 (out) 
                   (memo 'tofu `(a b tofu d tofu e) out))
              `((tofu d tofu e)))

  ;; not perserving non-overlapping property
  (test-check "4.10 *"
              (run* (out) 
                   (memo 'tofu `(a b tofu d tofu e) out))
              `((tofu d tofu e) (tofu e)))

  
  (test-check "4.11"
              (run 1 (out) 
                   (fresh (x)
                          (memo 'tofu `(a b ,x d tofu e) out)))
              `((tofu d tofu e)))

  (test-check "4.12"
              (run* (r)
                    (memo r `(a b tofu d tofu e) `(tofu d tofu e)))
              (list `tofu))

  (test-check "4.13"
              (run* (q)
                    (memo 'tofu '(tofu e) '(tofu e))
                    (== #t q))
              (list #t))

  (test-check "4.14"
              (run* (q)
                    (memo 'tofu '(tofu e) '(tofu))
                    (== #t q))
              `())

  (test-check "4.15"
              (run* (x)
                    (memo 'tofu '(tofu e) `(,x e)))
              (list `tofu))

  (test-check "4.16"
              (run* (x)
                    (memo 'tofu '(tofu e) `(peas ,x)))
              `())

  (test-check "4.17"
              (run* (out) 
                    (fresh (x) 
                           (memo 'tofu `(a b ,x d tofu e) out)))
              `((tofu d tofu e) (tofu e)))

  (test-check "4.18"
              (run 12 (z)
                   (fresh (u)
                          (memo 'tofu `(a b tofu d tofu e . ,z) u)))
              `(_.0
                _.0
                (tofu . _.0)
                (_.0 tofu . _.1)
                (_.0 _.1 tofu . _.2)
                (_.0 _.1 _.2 tofu . _.3)
                (_.0 _.1 _.2 _.3 tofu . _.4)
                (_.0 _.1 _.2 _.3 _.4 tofu . _.5)
                (_.0 _.1 _.2 _.3 _.4 _.5 tofu . _.6)
                (_.0 _.1 _.2 _.3 _.4 _.5 _.6 tofu . _.7)
                (_.0 _.1 _.2 _.3 _.4 _.5 _.6 _.7 tofu . _.8)
                (_.0 _.1 _.2 _.3 _.4 _.5 _.6 _.7 _.8 tofu . _.9)))


  (run 5 ( q)
     (fresh (x y)
            (memo 'fig `(fig d fig e . ,y) x)
            (== `(,x ,y) q)))
;; '(((fig d fig e . _.0) _.0)
;;   ((fig e . _.0) _.0)
;;   ((fig . _.0) (fig . _.0))
;;   ((fig . _.0) (_.1 fig . _.0))
;;   ((fig . _.0) (_.1 _.2 fig . _.0)))


  
  )
