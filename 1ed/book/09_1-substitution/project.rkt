#lang racket
(require "../libs/trs/mk.rkt")
(require "../libs/trs/mkextraforms.rkt")
(require "../libs/trs/mkprelude.rkt")
(require "../libs/test-harness.rkt")

(test-check "9.47"
            (run* (q)
                  (== #f q)
                  (project (q)
                           (== (not (not q)) q)))
            '(#f))

(run* (q)
      (== #f q)
      (project (q)
               (== (not (not q)) q)))

(run* (q)
      (== #f q)
      (== (not (not q)) q))

;; 注意：这个q是一个scheme变量，它的值是一个fresh var
;; 最初subst里该var关联的value是#f
;; 我们使用trace-vars打印的q就是subst里该var关联的value
;; 但是这个scheme变量q的值仍然是(var 'x) which是一个vector
;; 因此(not (not q))实际上是(not (not (var 'x)))
;; 因此(== (not (not q)) q)失败，因为#t != (var 'x)
(run* (q)
      (== #f q)
      (trace-vars "What it is!" q)
      (== (not (not q)) q))
