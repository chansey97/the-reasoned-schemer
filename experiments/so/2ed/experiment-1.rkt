#lang racket
(require "../../../book/2ed/libs/trs2/trs2-impl.rkt")

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
