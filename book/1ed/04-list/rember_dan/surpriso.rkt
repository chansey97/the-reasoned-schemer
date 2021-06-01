#lang racket
(require "../../libs/trs/mk.rkt")
(require "./rembero_fix.rkt")
(provide (all-defined-out))

; 4.68
(define surpriseo
  (lambda (s)
    (rembero s '(a b c) '(a b c))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")
  
  (test-check "4.69"
              (run* (r)
                    (== 'd r)
                    (surpriseo r))
              `(d))
  
  ;; Still surprising
  ;; (surpriseo r) does not propagate the =/= constraints.
  
  ;; To fix this problem, use William E. Byrd's =/=,
  ;; see /book/1ed_ss/04-list/rember_dan/surpriso_fix.rkt
  
  (test-check "?????"
              (run* (r)
                    (surpriseo r)
                    (== 'd r))
              `())

  (test-check "4.70"
              (run* (r)
                    (surpriseo r))
              '())
  
  (test-check "4.71"
              (run* (r)
                    (surpriseo r)
                    (== 'b r))
              '())
  
  (test-check "4.72"
              (run* (r)
                    (== 'b r)
                    (surpriseo r))
              '())
  )
