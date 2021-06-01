#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(provide (all-defined-out))

;; 6.1
(defrel (alwayso)
  (conde
   (succeed)
   ((alwayso))))

(module+ main
  (require "../libs/test-harness.rkt")

  
  ;; 6.11
  (run 1 q
       (conde
        ((== 'garlic q)
         (alwayso))
        ((== 'onion q)))
       (== 'onion q))

  
  ;; 6.12
  (test-divergence "6.12"
                   (run 2 q
                        (conde
                         ((== 'garlic q)
                          (alwayso))
                         ((== 'onion q)))
                        (== 'onion q)))
  
  ;; 6.13
  (run 5 q
       (conde
        ((== 'garlic q)
         (alwayso))
        ((== 'onion q)
         (alwayso)))
       (== 'onion q))

  )
