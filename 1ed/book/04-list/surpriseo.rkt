#lang racket
(require "../libs/trs/mk.rkt")
(require "../02-pair/null.rkt")
(require "../02-pair/cons.rkt")
(require "../03-list/member/eq-caro.rkt")
(require "./rember.rkt")
(provide (all-defined-out))

; 4.68
(define surpriseo
  (lambda (s)
    (rembero s '(a b c) '(a b c))))

(module+ main
  (require "../libs/trs/mkextraforms.rkt")
  (require "../libs/test-harness.rkt")
  
  (test-check "4.69"
              (run* (r)
                    (== 'd r)
                    (surpriseo r))
              (list 'd))

  (test-check "4.70"
              (run* (r)
                    (surpriseo r))
              `(_.0))

  (test-check "4.72"
              (run* (r)
                    (== 'b r)
                    (surpriseo r))
              `(b))
  )
