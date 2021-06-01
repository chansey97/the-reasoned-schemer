#lang racket
(require text-table)
(provide (all-defined-out))

(define (pretty-print-matrix lol)
  (displayln
   (table->string lol
                  #:border-style
                  '(#\space ("(" " " ")")
                    ("(" "" "")
                    ("" "" "")
                    (")" "" ""))
                  #:framed? #t
                  #:row-sep? #f
                  #:align  '(left))))

