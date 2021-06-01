#lang racket
(provide (all-defined-out))

;; 10.56
(define (append-inf s-inf t-inf)
  (cond
    ((null? s-inf) t-inf)
    ((pair? s-inf) 
     (cons (car s-inf)
       (append-inf (cdr s-inf) t-inf)))
    (else (lambda () 
            (append-inf t-inf (s-inf))))))

;; 修改成和From Variadic Functiions to Variadic Relation pdf的样子
;; (define (append-inf s-inf t-inf)
;;   (cond
;;     ((null? s-inf) t-inf)
;;     ((pair? s-inf) 
;;      (cons (car s-inf)
;;        (append-inf (cdr s-inf) t-inf)))
;;     (else (lambda () 
;;             (append-inf (t-inf) s-inf))))) ;; 注意这里

;; μKarenren Section 4.3，这将导致DFS which is 不完全查询
;; (define (append-inf s-inf t-inf)
;;   (cond
;;     ((null? s-inf) t-inf)
;;     ((pair? s-inf) 
;;      (cons (car s-inf)
;;        (append-inf (cdr s-inf) t-inf)))
;;     (else (lambda () 
;;             (append-inf (s-inf) t-inf )))))
