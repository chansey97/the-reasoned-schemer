#lang racket
(require "../../libs/trs2/trs2-impl.rkt")
(require "../../02_1-pair/conso.rkt")
(provide (all-defined-out))

;; 4.45
(define (unwrap x)
  (cond ((pair? x) (unwrap (car x)))
        (#t x)))

;; 4.47
(defrel (unwrapo x out)
  (conde
   ((fresh (a)
           (caro x a)
           (unwrapo a out)))
   ((== x out))))

(module+ main

  ;; 4.52
  (run 5 x
       (unwrapo x 'pizza))


  ;; 4.54
  (run 5 x
       (unwrapo `((,x)) 'pizza))

  )
