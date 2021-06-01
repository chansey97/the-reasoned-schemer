#lang racket
(require "../libs/trs2/trs2-impl.rkt")

; 1.65
(run* x
      (disj2
       (conj2 (== 'virgin x) fail)
       (disj2
        (== 'olive x)
        (disj2
         succeed
         (== 'oil x)))))


;; associative law

; 1.67
(run* r
      (fresh (x)
             (fresh (y)
                    (conj2
                     (== 'split x)
                     (conj2
                      (== 'pea y)
                      (== `(,x ,y) r))))))
; 1.68
(run* r
      (fresh (x)
             (fresh (y)
                    (conj2
                     (conj2
                      (== 'split x)
                      (== 'pea y))
                     (== `(,x ,y) r)))))

