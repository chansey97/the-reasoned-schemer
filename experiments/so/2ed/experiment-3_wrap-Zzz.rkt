#lang racket
(require "../../../book/2ed/libs/trs2/trs2-impl.rkt")

(define-syntax Zzz
  (syntax-rules ()
    [(_ g) (λ (s) (λ () (g s)))]))

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
             ((== 'b x) (Zzz (conde
                              ((== 'e y) )
                              ((== 'f y))))))
            (== `(,x ,y) r)))

;; => '((a c) (b e) (b f)) 
