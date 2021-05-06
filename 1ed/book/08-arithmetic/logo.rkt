#lang racket
(require "../libs/trs/mk.rkt")
(require "../05-list/append/appendo_2_correct.rkt")
(require "../07-arithmetic/poso.rkt")
(require "../07-arithmetic/gt1o.rkt")
(require "../07-arithmetic/addo.rkt")
(require "./mulo_1_correct.rkt")
(require "./divo_2_correct.rkt")
(require "./length-comparison/eqlo.rkt")
(require "./length-comparison/ltlo.rkt")
(require "./length-comparison/ltelo_2_correct.rkt")
(require "./comparison/lto.rkt")
(require "./splito.rkt")
(provide (all-defined-out))

;; TODO:
;; The definition of logo in the first printing of Friedman et al. (2005) contains an error, which
;; has been corrected in the second printing and in section 6.6.
;; see Relational Programming in miniKanren Chapter 6

; 8.82.1
(define logo
  (lambda (n b q r)
    (condi
     ((== '(1) n) (poso b) (== '() q) (== '() r))
     ((== '() q) (<o n b) (+o r '(1) n))
     ((== '(1) q) (>1o b) (=lo n b) (+o r b n))
     ((== '(1) b) (poso q) (+o r '(1) n))
     ((== '() b) (poso q) (== r n))
     ((== '(0 1) b)
      (fresh (a ad dd)
             (poso dd)
             (== `(,a ,ad . ,dd) n)
             (exp2 n '() q)
             (fresh (s)
                    (splito n dd r s))))
     ((fresh (a ad add ddd)
             (conde
              ((== '(1 1) b))
              (else (== `(,a ,ad ,add . ,ddd) b))))
      (<lo b n)
      (fresh (bw1 bw nw nw1 ql1 ql s)
             (exp2 b '() bw1)
             (+o bw1 '(1) bw)
             (<lo q n)
             (fresh (q1 bwq1)
                    (+o q '(1) q1)
                    (*o bw q1 bwq1)
                    (<o nw1 bwq1))
             (exp2 n '() nw1)
             (+o nw1 '(1) nw)
             (/o nw bw ql1 s)
             (+o ql '(1) ql1)
             (conde
              ((== q ql))
              (else (<lo ql q)))
             (fresh (bql qh s qdh qd)
                    (repeated-mul b ql bql)        
                    (/o nw bw1 qh s)                
                    (+o ql qdh qh)
                    (+o ql qd q)
                    (conde
                     ((== qd qdh))
                     (else (<o qd qdh)))
                    (fresh (bqd bq1 bq)
                           (repeated-mul b qd bqd)        
                           (*o bql bqd bq)                
                           (*o b bq bq1)                
                           (+o bq r n)
                           (<o n bq1)))))
     (else fail))))

; 8.82.2
(define exp2
  (lambda (n b q)
    (condi
     ((== '(1) n) (== '() q))
     ((>1o n) (== '(1) q)
              (fresh (s)
                     (splito n b s '(1))))
     ((fresh (q1 b2)                        
             (alli                 
              (== `(0 . ,q1) q)
              (poso q1)
              (<lo b n)
              (appendo b `(1 . ,b) b2)
              (exp2 n b2 q1))))
     ((fresh (q1 nh b2 s)                
             (alli
              (== `(1 . ,q1) q)
              (poso q1)
              (poso nh)
              (splito n b s nh)
              (appendo b `(1 . ,b) b2)
              (exp2 nh b2 q1))))
     (else fail))))

; 8.82.3
(define repeated-mul
  (lambda (n q nq)
    (conde
     ((poso n) (== '() q) (== '(1) nq))
     ((== '(1) q) (== n nq))
     ((>1o q)
      (fresh (q1 nq1)
             (+o q1 '(1) q)
             (repeated-mul n q1 nq1)
             (*o nq1 n nq)))
     (else fail))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "8.89"
    (run* (r) 
      (logo '(0 1 1 1) '(0 1) '(1 1) r))
    (list `(0 1 1)))

  (cout "This next test takes several minutes to run!" nl)

  (test-check "8.96"
    (run 8 (s)
      (fresh (b q r)
        (logo '(0 0 1 0 0 0 1) b q r)
        (>1o q)
        (== `(,b ,q ,r) s)))
    `(((1) (_.0 _.1 . _.2) (1 1 0 0 0 0 1))
      (() (_.0 _.1 . _.2) (0 0 1 0 0 0 1))
      ((0 1) (0 1 1) (0 0 1))        
      ((0 0 1) (1 1) (0 0 1))
      ((1 0 1) (0 1) (1 1 0 1 0 1))
      ((0 1 1) (0 1) (0 0 0 0 0 1))
      ((1 1 1) (0 1) (1 1 0 0 1))
      ((0 0 0 1) (0 1) (0 0 1))))

  )
