#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "../07-arithmetic/poso.rkt")
(provide (all-defined-out))

(defrel (splito n r l h)
  (conde
    ((== '() n) (== '() h) (== '() l))
    ((fresh (b n^)
       (== `(0 ,b . ,n^) n) (== '() r)
       (== `(,b . ,n^) h) (== '() l)))
    ((fresh (n^)
       (==  `(1 . ,n^) n) (== '() r)
       (== n^ h) (== '(1) l)))
    ((fresh (b n^ a r^)
       (== `(0 ,b . ,n^) n)
       (== `(,a . ,r^) r) (== '() l)
       (splito `(,b . ,n^) r^ '() h)))
    ((fresh (n^ a r^)
       (== `(1 . ,n^) n)
       (== `(,a . ,r^) r) (== '(1) l)
       (splito n^ r^ '() h)))
    ((fresh (b n^ a r^ l^)
       (== `(,b . ,n^) n)
       (== `(,a . ,r^) r)
       (== `(,b . ,l^) l)
       (poso l^)
       (splito n^ r^ l^ h)))))

(module+ main

  ;; 
  (run* (l h)
        (splito '(0 0 1 0 1 1 1) '(1 1 1) l h))

  ;; '(((0 0 1) (1 1 1)))

  (run* (n)
        (splito n '(1 1 1) '(0 0 1) '(1 1 1)))

  ;; '(((0 0 1 0 1 1 1)))

  )

