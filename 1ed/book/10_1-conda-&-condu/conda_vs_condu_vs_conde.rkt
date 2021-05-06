
;; conda and condu often lead to fewervalues than a similar expression that uses conde.

(test-check "10.21"
  (run* (r)
    (conde
      ((teacupo r) succeed)
      ((== #f r) succeed)
      (else fail)))
  `(tea cup #f))

(test-check "10.22"
  (run* (r)
    (conda
      ((teacupo r) succeed)
      ((== #f r) succeed)
      (else fail)))
  `(tea cup))

;; no difference when question of conde/condu fail
(test-check "10.23"
  (run* (r)
    (== #f r)
    (conda
      ((teacupo r) succeed)
      ((== #f r) succeed)
      (else fail)))
  `(#f))

;; no difference when question of conde/condu fail
(test-check "10.24"
  (run* (r)
    (== #f r)
    (condu
      ((teacupo r) succeed)
      ((== #f r) succeed)
      (else fail)))
  `(#f))
