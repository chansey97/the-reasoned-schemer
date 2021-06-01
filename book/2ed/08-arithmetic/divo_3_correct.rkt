#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../07-arithmetic/poso.rkt")
(require "../07-arithmetic/pluso.rkt")
(require "../07-arithmetic/minuso.rkt")
(require "./mulo.rkt")
(require "./length-comparison/eqlo.rkt")
(require "./length-comparison/ltlo.rkt")
(require "./length-comparison/ltelo.rkt")
(require "./comparison/lto.rkt")
(require "./splito.rkt")
(provide (all-defined-out))

; Final definition of '/o' from frame 8:81 on page 124.
(defrel (/o n m q r)
  (conde
    ((== '() q) (== r n) (<o n m))
    ((== '(1) q) (=lo m n) (pluso r m n) ; 长度相等，则商只可能是1。因为n的最大值要再大1才变成了2倍的m
     (<o r m))
    ((poso q) (<lo m n) (<o r m)
     (n-wider-than-mo n m q r))))

(defrel (n-wider-than-mo n m q r)
  (fresh (nh nl qh ql)
    (fresh (mql mrql rr rh)
      (splito n r nl nh) ; 同一个r，因此 nl 和 ql + padding之后长度一样
      (splito q r ql qh)
      (conde
        ((== '() nh)
         (== '() qh)
         (minuso nl r mql) ; nlow = mql + rlow, nlow = m * qlow  + rlow
         (*o m ql mql)) ; m * qlow = mql
        ((poso nh)
         (*o m ql mql) ; m * ql = mql
         (pluso r mql mrql) ; r + mql = mrql ; r + m*ql = mrql 
         (minuso mrql nl rr) ; mrql - nl = rr
         (splito rr r '() rh)
         (/o nh m qh rh))))))

