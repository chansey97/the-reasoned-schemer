

(run* (x y)
      (appendo x y '(cake & ice d t)))

(let ((q (var 'q)))
  (map (reify q)
       (run-goal #f
                 (call/fresh 'x
                   (lambda (x)
                     (call/fresh 'y
                       (lambda (y)
                         (conj2
                           (≡ ‘(,x ,y) q)
                           (appendo x y '(cake & ice d t)))))))))).
