#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../02-pair/null.rkt")
(require "../../02-pair/cons.rkt")
(require "../list.rkt")
(require "./eq-caro.rkt")
(provide (all-defined-out))

;; Note that the correct version of pmembero doesn't provided in 1ed
;; The following uses 2ed definition.

; 3.93
(define pmembero
  (lambda (x l)
    (conde
     ((eq-caro l x)
      (fresh (d)
             (cdro l d)
             (listo d)
             ))
     
     (else 
      (fresh (d)
             (cdro l d)
             (pmembero x d))))))

(module+ main
  (require "../../libs/trs/mkextraforms.rkt")
  (require "../../libs/test-harness.rkt")

  (run 12 (l)
       (pmembero 'tofu l))
  
  (test-check ""
              (run 12 (l)
                   (pmembero 'tofu l))
              '((tofu)
                (tofu _.0)
                (tofu _.0 _.1)
                (tofu _.0 _.1 _.2)
                (tofu _.0 _.1 _.2 _.3)
                (tofu _.0 _.1 _.2 _.3 _.4)
                (tofu _.0 _.1 _.2 _.3 _.4 _.5)
                (tofu _.0 _.1 _.2 _.3 _.4 _.5 _.6)
                (tofu _.0 _.1 _.2 _.3 _.4 _.5 _.6 _.7)
                (tofu _.0 _.1 _.2 _.3 _.4 _.5 _.6 _.7 _.8)
                (tofu _.0 _.1 _.2 _.3 _.4 _.5 _.6 _.7 _.8 _.9)
                (tofu _.0 _.1 _.2 _.3 _.4 _.5 _.6 _.7 _.8 _.9 _.10)))

  (run* (q)
        (pmembero 'tofu `(a b tofu d x)))
  ;; '(_.0)

  (run* (q)
        (pmembero 'tofu `(a b tofu d . x)))
  ;; '() ; OK

  )


