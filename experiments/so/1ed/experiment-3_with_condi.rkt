#lang racket
(require "../../../book/1ed/libs/trs/mk.rkt")
(require "../../../book/1ed/libs/trs/mkextraforms.rkt")

(define (tmp-rel y)
  (conde
   ((== 'c y) )
   ((tmp-rel-2 y))))

(define (tmp-rel-2 y)
  (all (== 'd y)
       (tmp-rel-2 y)))

(run 1 (r)
      (fresh (x y)
             (condi
              ((== 'a x) (tmp-rel y)) 
              ((== 'b x) (condi
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))
;; '((a c))

(run 2 (r)
      (fresh (x y)
             (condi
              ((== 'a x) (tmp-rel y)) 
              ((== 'b x) (condi
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))
;; '((a c) (b e))

;; However, it still cannot print the third solution (b f) because condi can’t work well with divergence.

