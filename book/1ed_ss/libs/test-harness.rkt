#lang racket
(provide (all-defined-out))

(define-syntax test-check
  (syntax-rules ()
    ((_ title tested-expression expected-result)
     (begin
       (cout "Testing " title nl)
       (let* ((expected expected-result)
              (produced tested-expression))
         (or (equal? expected produced)
             (errorf 'test-check
                     "Failed: ~a~%Expected: ~a~%Computed: ~a~%"
                     'tested-expression expected produced)))))))

(define nl (string #\newline))

(define (cout . args)
  (for-each (lambda (x)
              (if (procedure? x) (x) (display x)))
            args))

(define errorf
  (lambda (tag . args)
    (display "Failed: ") (display tag) (newline)
    (for-each  display args)
    (error 'WiljaCodeTester "That's all, folks!")))

;; (define-syntax test-divergence
;;   (syntax-rules ()
;;     ((_ title tested-expression)
;;      (let ((max-ticks 10000000))
;;        (cout "Testing " title " (engine with " max-ticks " ticks fuel)" nl)
;;        ((make-engine (lambda () tested-expression))
;;         max-ticks
;;         (lambda (t v)
;;           (errorf title
;;                   "infinite loop returned " v " after " (- max-ticks t) " ticks"))
;;         (lambda (e^) (void)))))))

;;; Comment out this definition to test divergent code (Chez Scheme only)
(define-syntax test-divergence
  (syntax-rules ()
    ((_ title tested-expression) (cout "Ignoring divergent test " title nl))))

(module+ main

  (define (loop)
    (loop))
  
  (test-divergence "loop"
                   (loop))

  (test-divergence "no loop"
                   (+ 1 2))
  )
