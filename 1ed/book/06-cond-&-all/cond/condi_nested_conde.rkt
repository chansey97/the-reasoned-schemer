#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")

; 1.56
(define teacupo
  (lambda (x)
    (conde
     ((== 'tea x) succeed)
     ((== 'cup x) succeed)
     (else fail))))

(test-check "6.24"
            (run 5 (r)
                 (condi
                  ((teacupo r) succeed)
                  ((== #f r) succeed)
                  (else fail)))
            `(tea #f cup))

(run 5 (r)
     (conde
      ((teacupo r) succeed)
      ((== #f r) succeed)
      (else (== #t r))))
;; => '(tea cup #f #t)

(run 5 (r)
     (condi
      ((teacupo r) succeed)
      ((== #f r) succeed)
      (else (== #t r))))
;; => '(tea #f cup #t) , not  '(tea #f #t cup)

;; Because
;; (tea cup) mplus (#f #t)
;; = '(tea cup #f #t)

;; Note that multiple clauses in condi is exactly nested condi
(run 5 (r)
     (condi
      ((teacupo r) succeed)
      (else (condi
             ((== #f r) succeed)
             (else (== #t r))))))
;; => '(tea #f cup #t)
