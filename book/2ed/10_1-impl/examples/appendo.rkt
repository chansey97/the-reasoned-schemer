

(defrel (appendo l t out)
  (conde
   ((nullo l) (== t out))
   ((fresh (a d res)
           (conso a d l)
           (conso a res out)
           (appendo d t res)
           ))))


(define (appendo l t out)
  (lambda (s)
    (lambda ()
      ((disj2
        (conj2 (nullo l) (≡ t out))
        (call/fresh 'a
                    (lambda (a)
                      (call/fresh 'd
                                  (lambda (d)
                                    (call/fresh 'res
                                                (lambda (res)
                                                  (conj2
                                                   (conso a d l)
                                                   (conj2
                                                    (conso a res out)
                                                    (appendo d t res))))))))))
       s))))
