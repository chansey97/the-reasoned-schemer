#lang racket
(require "../../../book/1ed_s/libs/minikanren/minikanren.rkt")
(require "../../../book/1ed_s/common.rkt")

(define (tmp-rel y)
  (conde
   ((== 'c y) )
   ((tmp-rel-2 y))))

(define (tmp-rel-2 y)
  (fresh (x)
         (== 'd y)
         (tmp-rel-2 y)))

(run 2 (r)
      (fresh (x y)
             (conde
              ((== 'a x) (tmp-rel y))
              ((== 'b x) (conde
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))

;; => '((a c) (b e))

;; However, run 3 loops.

;; Note that it still cannot print the third solution (b f) because tmp-rel-2 does not be wrapped in conde, so no suspension is created here.

;; If we expect '((a c) (b e) (b f)), we can wrap the suspension manually:
