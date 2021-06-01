#lang racket
(require "../../../book/1ed/libs/trs/mk.rkt")
(require "../../../book/1ed/libs/trs/mkextraforms.rkt")

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

;; => '((a c) (a d) (b e) (b f))
