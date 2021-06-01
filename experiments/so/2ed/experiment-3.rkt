#lang racket
(require "../../../book/2ed/libs/trs2/trs2-impl.rkt")

(defrel (tmp-rel y)
  (conde
   ((== 'c y) )
   ((tmp-rel-2 y))))

(defrel (tmp-rel-2 y)
  (== 'd y)
  (tmp-rel-2 y))

(run 3 r
      (fresh (x y)
             (conde
              ((== 'a x) (tmp-rel y))
              ((== 'b x) (conde
                          ((== 'e y) )
                          ((== 'f y)))))
             (== `(,x ,y) r)))
             
;; => '((b e) (b f) (a c)) 

;; This is OK, except that the order is not as expected.

;; Notice that (a c) is at the last now.

;; Note that the final result is '((b e) (b f) (a c)) instead of '((a c) (b e) (b f)) because in TRS2, a suspension only initially be created by defrel.

;; If we expect '((a c) (b e) (b f)), we can wrap the suspension manually:
