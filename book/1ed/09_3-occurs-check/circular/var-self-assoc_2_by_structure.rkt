#lang racket
(require "../../libs/trs/mk.rkt")
(require "../../libs/trs/mkextraforms.rkt")
(require "../../libs/test-harness.rkt")

; 9.6
(define u (var 'u)) 
(define v (var 'v))
(define w (var 'w))
(define x (var 'x))
(define y (var 'y))
(define z (var 'z))

;; circular type 2
;; 通过结构间接的循环关联

`((,x . (,x)))
;; '((#(x) #(x))) = '((#(x) . (#(x))))

`((,x . (,y)) (,y . (,x)))
;; '((#(x) #(y)) (#(y) #(x))) = '((#(x) . (#(y))) (#(y) . (#(x))))

;; 注意1：
;; 对这类circular进行可以进行安全walk，因为walk不会解析结构里面的变量
;; 对这类circular不能安全walk*，可能loop

(walk x `((,x . (,x))))
;; '(#(x))

(test-divergence "(walk* x `((,x . (,x))))"
                 (walk* x `((,x . (,x)))))

(walk x `((,x . (,y)) (,y . (,x))))
;; '(#(y))

(test-divergence "(walk* x `((,x . (,y)) (,y . (,x))))"
                 (walk* x `((,x . (,y)) (,y . (,x)))))

;; 注意2：
;; unify可能构造这样的circular
((all
  (== `(,x) x)) empty-s)
;; '((#(x) #(x))) = '((#(x) . (#(x))))

(unify `(,x) x empty-s)
;; '((#(x) #(x))) = '((#(x) . (#(x))))

((all
  (== `(,x) y)
  (== `(,y) x)) empty-s)
;; '((#(x) #(y)) (#(y) #(x))) = '((#(x) . (#(y))) (#(y) . (#(x))))

(unify `(,y) x
       (unify `(,x) y empty-s))
;; '((#(x) #(y)) (#(y) #(x))) = '((#(x) . (#(y))) (#(y) . (#(x))))

;; 因此，通过unify构造的substitution一定可以安全walk，但不一定能安全walk*

;; 事实上，你在minikanren里不应该写circular的代码，
;; 因为在(run 1 ...)里，最终总会reify一个变量 which 需要walk*，
;; 如果你写了circular的代码则会导致loop。

;; 上面的代码还比较容易发现circular，比如：(== `(,x) x)，
;; 但更复杂的代码，程序员可能难以发现这种circular。

;; 解决方法：
;; 使用occurs-check，即：使用unify-check which保证不会出现circular
;; see avoid-circular-by-occurs-check.rkt
;; 注意
;; 这里只能保证使用unify-check创建的substitution一定不是circular
;; 但不能check一个substitution是否是circular，但我们不需要这样的check，因为我们所有的substitution都通过unify构建的
;; 对一个已经是circular的substitution强行occurs-check，则occurs-check自己会loop




;; occur-check

;; (unify `(p ,x ,x) `(p ,y (f ,y)) empty-s)

;; '((#(y) . (f #(y)))
;;   (#(x) . #(y)))
