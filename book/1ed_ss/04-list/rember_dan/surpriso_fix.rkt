#lang racket
(require "../../libs/miniKanren/mk.rkt")
(require "./rembero_fix.rkt")
(provide (all-defined-out))

; 4.68
(define surpriseo
  (lambda (s)
    (rembero s '(a b c) '(a b c))))

(module+ main
  (require "../../libs/miniKanren/mk.rkt")
  (require "../../libs/test-harness.rkt")
  
  ;; (test-check "4.69"
              (run* (r)
                    (== 'd r)
                    (surpriseo r))
              ;; `(d))
  
  ;; (test-check "?????"
              (run* (r)
                    (surpriseo r)
                    (== 'd r))
              ;; `())
  
  ;; (test-check "4.70"
              (run* (r)
                    (surpriseo r))
              ;; '())
  
  ;; (test-check "4.71"
              (run* (r)
                    (surpriseo r)
                    (== 'b r))
              ;; '())
  
  ;; (test-check "4.72"
              (run* (r)
                    (== 'b r)
                    (surpriseo r))
              ;; '())
  )
