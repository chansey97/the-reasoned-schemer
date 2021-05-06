#lang racket
(provide (all-defined-out))

;; ; 7.43
;; (define build-num
;;   (lambda (n)
;;     (cond
;;       ((zero? n) '())
;;       ((and (not (zero? n)) (even? n))
;;        (cons 0
;;          (build-num (quotient n 2))))
;;       ((odd? n)
;;        (cons 1
;;          (build-num (quotient (- n 1) 2)))))))

; 7.44
(define build-num
  (lambda (n)
    (cond
      ((odd? n)
       (cons 1
         (build-num (quotient (- n 1) 2))))    
      ((and (not (zero? n)) (even? n))
       (cons 0
         (build-num (quotient n 2))))
      ((zero? n) '()))))


(module+ main
  (require "../libs/test-harness.rkt")
  
  (test-check "7.25"
              `(1 0 1) 
              (build-num 5))

  (test-check "7.26"
              `(1 1 1)
              (build-num 7))
  
  (test-check "7.27"
              (build-num 9)
              `(1 0 0 1))

  (test-check "7.28"
              (build-num 6)
              `(0 1 1))

  (test-check "7.31"
              (build-num 19) 
              `(1 1 0 0 1))

  (test-check "7.32"
              (build-num 17290)
              `(0 1 0 1 0 0 0 1 1 1 0 0 0 0 1))

  (test-check "7.40"
              (build-num 0)
              `())

  (test-check "7.41"
              (build-num 36)
              `(0 0 1 0 0 1))

  (test-check "7.42"
              (build-num 19)
              `(1 1 0 0 1))

  )

