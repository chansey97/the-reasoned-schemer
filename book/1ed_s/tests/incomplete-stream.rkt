#lang racket
(require "../libs/minikanren/minikanren.rkt")

(define my-take
    (lambda (n f)
      (if (and n (zero? n))
          '()
          (case-inf (f)
                    '()
                    ((a) a)
                    ((a f) (cons a (my-take (and n (- n 1)) f)))
                    ((f) (my-take n f))))))
  
  (define stream-a
    (cons '1
      (thunk (cons '2
               (thunk (cons '3
                        (thunk #f)))))))
  (define stream-b 
    (cons '5
      (thunk (cons '6
               (thunk (cons '7
                        (thunk #f)))))))

  (my-take #f (thunk stream-a))
  (my-take #f (thunk stream-b))
  (my-take #f (thunk (mplus stream-a (thunk stream-b))))

  (my-take #f (thunk (bind (mplus stream-a (thunk stream-b))
                           (λ (x) (cons `(,x a)
                                    (thunk (cons `(,x b)
                                             (thunk #f))))))))

  (my-take #f (thunk (mplus (bind stream-a (λ (x)
                                             (cons `(,x a)
                                               (thunk (cons `(,x b)
                                                        (thunk #f))))))
                            (thunk (bind stream-b (λ (x)
                                                    (cons `(,x c)
                                                      (thunk (cons `(,x d)
                                                               (thunk #f))))))))))

  
  ;; (my-take #f (thunk (mplus (bind (thunk (cons 'a (thunk #f))) (λ (x)
  ;;                                                                (cons `(,x c)
  ;;                                                                  (thunk (cons `(,x d)
  ;;                                                                           (thunk #f))))))
  ;;                           (thunk (bind (thunk (cons 'b (thunk #f))) (λ (x)
  ;;                                                                       (cons `(,x e)
  ;;                                                                         (thunk (cons `(,x f)
  ;;                                                                                  (thunk #f))))))))))
