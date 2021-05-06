#lang racket
(require "../../libs/trs/mkextraforms.rkt")
(require "./memberrevo.rkt")
(provide (all-defined-out))

; 3.101
(define reverse-list
  (lambda (l)
    (run* (y)
      (memberrevo y l))))

(module+ main
  
  (reverse-list '(1 2 3 4))
  )
