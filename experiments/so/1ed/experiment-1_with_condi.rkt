#lang racket
(require "../../../book/1ed/libs/trs/mk.rkt")
(require "../../../book/1ed/libs/trs/mkextraforms.rkt")

(run* (r)
      (fresh (x y)
             (condi
              ((== 'a x) (condi
                          ((== 'c y) )
                          ((== 'd y))))
              ((== 'b x) (condi
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))

;; Note that if we replace conde with condi in TRS1, the result will be the same as TRS1*.

;; => '((a c) (b e) (a d) (b f))
