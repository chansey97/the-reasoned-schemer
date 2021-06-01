#lang racket
(require "../../../book/1ed_s/libs/minikanren/minikanren.rkt")
(require "../../../book/1ed_s/common.rkt")


(define (tmp-rel y)
  (conde
   ((== 'c y) )
   ((tmp-rel-2 y))))

(define (tmp-rel-2 y)
  (conde ((== 'd y) (tmp-rel-2 y)))) ; wrap a suspension by conde

(run 2 (r)
      (fresh (x y)
             (conde
              ((== 'a x) (tmp-rel y))
              ((== 'b x) (conde
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))

;; => '((a c) (b e))

(run 3 (r)
      (fresh (x y)
             (conde
              ((== 'a x) (tmp-rel y))
              ((== 'b x) (conde
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))

;; => '((a c) (b e) (b f)) 
