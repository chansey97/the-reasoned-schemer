#lang racket
(require "../../libs/miniKanren/mk.rkt")
(provide (all-defined-out))

;; see https://youtu.be/fHK-uS-Iedc?list=PLUtmotlo8IA49dzssf5xgnGfc7dziSbNw 10:30

(define rembero  
  (lambda (x l out)
    (conde
     ((== '() l) (== '() out))
     ((fresh (d)
             (== `(,x . ,d) l)
             (== d out)))
     ((fresh (a d res)
             (== `(,a . ,d) l)
             (=/= a x)
             (== `(,a . ,res) out)
             (rembero x d res)
             )))))

(module+ main
  (require "../../libs/miniKanren/mk.rkt")

  ;; Fix problem 1
  (run 1 (q) (rembero 'b '(a b c) q))
  ;; '((a c)) ; OK
  
  (run 2 (q) (rembero 'b '(a b c) q))
  ;; '((a c))
  )
