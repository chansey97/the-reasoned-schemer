#lang racket
(require "../../libs/trs/mk.rkt")
(require "./rembero.rkt")
(provide (all-defined-out))

; 4.68
; (surpriseo s) should succeed for all values of s other than a, b, and c.
(define surpriseo
  (lambda (s)
    (rembero s '(a b c) '(a b c))))

;; The reason of surprising is that
;; The 2nd and 3rd lines of conde in rembero are overlapping
(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "4.69"
              (run* (r)
                    (== 'd r)
                    (surpriseo r))
              `(d))
  
  (test-check ""
              (run* (r)
                    (surpriseo r)
                    (== 'd r))
              `(d))
  
  (test-check "4.70"
              (run* (r)
                    (surpriseo r))
              `(_.0))
  
  (test-check "4.71"
              (run* (r)
                    (surpriseo r)
                    (== 'b r))
              `(b))
  
  (test-check "4.72"
              (run* (r)
                    (== 'b r)
                    (surpriseo r))
              `(b))
  )
