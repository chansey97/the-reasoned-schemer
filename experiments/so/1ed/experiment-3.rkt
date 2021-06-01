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
             (conde
              ((== 'a x) (tmp-rel y)) 
              ((== 'b x) (conde
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))

;; => '((a c))

;; However, run 2 or run 3 loops.

;; If I use condi instead of conde, then run 2 works but run 3 still loop.
