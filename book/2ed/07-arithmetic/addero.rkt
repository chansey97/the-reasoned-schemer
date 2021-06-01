#lang racket
(require "../libs/trs2/trs2-impl.rkt")
(require "./full-addero.rkt")
(require "./poso.rkt")
(require "./gt1o.rkt")
(provide (all-defined-out))

;; It should be read declaratively by Horn clause.

;; 7.104
(defrel (addero b n m r)
  (conde
    ((== 0 b) (== '() m) (== n r))  ; ng1
    ((== 0 b) (== '() n) (== m r)   ; ng2
     (poso m))
    ((== 1 b) (== '() m)
     (addero 0 n '(1) r))
    ((== 1 b) (== '() n) (poso m)
     (addero 0 '(1) m r))
    ((== '(1) n) (== '(1) m) ; g1
     (fresh (a c)
       (== `(,a ,c) r)
       (full-addero b 1 1 a c)))
    ((== '(1) n) (gen-addero b n m r)) ; ng3 g2 ng4
    ((== '(1) m) (>1o n) (>1o r)  ; ng5
                 (addero b '(1) n r))

    ;; 当call (addero 0 x y r)
    ;; 上面的clause包含了一下值
    ;; (_0            ()                _0               ) ng1 
    ;; (()            (_0 . _1)         (_0 . _1)        ) ng2 
    ;; ((1)           (1)               (0 1)            ) g1  
    ;; ((1)           (0 _0 . _1)       (1 _0 . _1)      ) ng3 
    ;; ((1)           (1 1)             (0 0 1)          ) g2  
    ;; ((0 1)         (0 1)             (0 0 1)          ) g3  
    ;; ((1)           (1 0 _0 . _1)     (0 1 _0 . _1)    ) ng4 
    ;; ((0 _0 . _1)   (1)               (1 _0 . _1)      ) ng5 
    ;;下面这个clasue才是真正的递归
    ((>1o n) (gen-addero b n m r))))

;; 7.104
;; n>=1  m>1 r>1的加法
;; 因为只要满足这样的加法，才能够用加法器，拆分m n的头出来加
(defrel (gen-addero b n m r)
  (fresh (a c d e x y z)
    (== `(,a . ,x) n)
    (== `(,d . ,y) m) (poso y) ; 这里其实是进一步分解了y
    (== `(,c . ,z) r) (poso z) ; 这里其实是进一步分解了z
    (full-addero b a d c e) ; b a d c e是fresh 因此这里会产生多值
    (addero e x y z)))
