#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../libs/trs2/trs2-arith.rkt")

;; 7.120
(defrel (lengtho l n)
  (conde
   ((nullo l) (== '() n))
   ((fresh (d res)
           (cdro l d)
           (pluso '(1) res n)
           (lengtho d res)))))

(module+ main
  (require "../libs/test-harness.rkt")
  
  ;; ; 7.121
  ;; (run 1 n
  ;;      (lengtho '(jicama rhubarb guava) n))

  (test-divergence ""
                   (run* n
                         (lengtho '(jicama rhubarb guava) n)))

  ;; 7.125
  (test-divergence "7.125"
                   (run 4 q
                        (lengtho q q)))
  
  )
