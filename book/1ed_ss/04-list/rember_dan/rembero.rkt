#lang racket
(require "../../libs/miniKanren/mk.rkt")
(provide (all-defined-out))

;; miniKanren Philosophy - William Byrd & Daniel Friedman

;; The code in the TRS1 is not very readable, we can rewrite it:
;; see https://youtu.be/fHK-uS-Iedc?list=PLUtmotlo8IA49dzssf5xgnGfc7dziSbNw 10:00
(define rembero  
  (lambda (x l out)
    (conde
     ((== '() l) (== '() out))
     ((fresh (d)
             (== `(,x . ,d) l)
             (== d out)))
     ((fresh (a d res) ; overlapping with 2nd line of conde
             (== `(,a . ,d) l)
             (rembero x d res) ; the recursive relation call has not sink to the bottom
             (== `(,a . ,res) out)
             )))))

;; Note:
;; There are two problems in the `rembero` definition:

;; 1. The 2nd and 3rd line of conde are overlapping.
;; see https://youtu.be/fHK-uS-Iedc?list=PLUtmotlo8IA49dzssf5xgnGfc7dziSbNw 10:30

;; 2. The recursive relation call `(rembero x d res)` has not sink to the bottom.
;; see https://youtu.be/fHK-uS-Iedc?list=PLUtmotlo8IA49dzssf5xgnGfc7dziSbNw 13:20
;;
;; When you run backwards you must sink the recursive all to the bottom.
;; The reason is that when you run backwards, the arguments' variables are fresh, see gen&testo of chapter 10:
;; (define gen&testo
;;   (lambda (op i j k)
;;     ;; (onceo
;;      (fresh (x y z)
;;             (op x y z) ; if move to the bottom, then no endless loop
;;             (== i x)
;;             (== j y)
;;             (== k z))
;;      ;; )
;;     ))
;; (run* (q)
;;       (gen&testo +o '(0 0 1) '(1 1) '(1 1 1))
;;       (== #t q))
;;
;; Note that if there are two recursive relation call, then you may need `alli` or `2ed` to rescue,
;; but you can no longer use run*. see 10:26 for why gen-addero requires alli instead of all

(module+ main
  (require "../../libs/miniKanren/mk.rkt")

  ;; Show problem 1
  (run 1 (q) (rembero 'b '(a b c) q))
  ;; '((a c)) ; OK
  
  (run 2 (q) (rembero 'b '(a b c) q))
  ;; '((a c) (a b c)) ; surprising!

  ;; To fix this problem, introduced =/=
  ;; see rember_dan/rembero_fix_1.rkt
  )
