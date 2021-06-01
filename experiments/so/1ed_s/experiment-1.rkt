#lang racket
(require "../../../book/1ed_s/libs/minikanren/minikanren.rkt")
(require "../../../book/1ed_s/common.rkt")

(run* (r)
      (fresh (x y)
             (conde
              ((== 'a x) (conde
                          ((== 'c y) )
                          ((== 'd y))))
              ((== 'b x) (conde
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))

;; => '((a c) (b e) (a d) (b f))
