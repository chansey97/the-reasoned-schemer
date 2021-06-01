#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../02_1-pair/conso.rkt")
(provide (all-defined-out))

;; 3.47
(defrel (membero x l)
  (conde
   ((caro l x))
   ((fresh (d)
           (cdro l d)
           (membero x d)))))

(module+ main

  ;; 3.52
  (run* y
        (membero y '()))
  
  ;; 3.53
  (run* y
        (membero y '(hummus with pita)))
  ;; So (run* y (membero y L)) is always L, when L is a proper list
  
  ;; 3.55
  (run* y
        (membero y '(pear grape . peaches)))
  ;; membero并没有约束l是plist，因此可以用于improper list

  ;; 3.57, filled in a black in the list
  (run* x
        (membero 'e `(pasta ,x fagioli)))

  )
