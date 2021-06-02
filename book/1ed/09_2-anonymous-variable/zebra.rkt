#lang racket
(require "../libs/trs/mk.rkt")
(require "../libs/trs/mkextraforms.rkt")
(require "./anonymous-variable.rkt")

;; The Zebra Problem.

;; Here is the specification of the problem:

;; 1. There are five houses in a row, each of a different color and inhabited by men
;; of different nationalities, with different pets, drinks, and cigarettes.

;; 2. The Englishman lives in the red house.

;; 3. The Spaniard owns a dog.

;; 4. Coffee is drunk in the green house.

;; 5. The Ukrainian drinks tea.

;; 6. The green house is directly to the right of the ivory house.

;; 7. The Old Golds smoker owns snails.

;; 8. Kools are being smoked in the yellow house.

;; 9. Milk is drunk in the middle house.

;; 10. The Norwegian lives in the first house on the left.

;; 11. The Chesterfields smoker lives next to the fox owner.

;; 12. Kools are smoked in the house next to the house where the horse is kept.

;; 13. The Lucky Strikes smoker drinks orange juice.

;; 14. The Japanese smokes Parliaments.

;; 15. The Norwegian lives next to the blue house.

;; 16. Who owns the zebra and who drinks the water?

(define (zebra houses)
  (all
   (== houses `((norwegian ,_ ,_ ,_ ,_) ,_ (,_ ,_ milk ,_ ,_) ,_ ,_))
   (memb `(englishman ,_ ,_ ,_ red) houses)
   (on-right `(,_ ,_ ,_ ,_ ivory) `(,_ ,_ ,_ ,_ green) houses)
   (next-to `(norwegian ,_ ,_ ,_ ,_) `(,_ ,_ ,_ ,_ blue) houses)
   (memb `(,_ kools ,_ ,_ yellow) houses)
   (memb `(spaniard ,_ ,_ dog ,_) houses)
   (memb `(,_ ,_ coffee ,_ green) houses)
   (memb `(ukrainian ,_ tea ,_ ,_) houses)
   (memb `(,_ luckystrikes oj ,_ ,_) houses)
   (memb `(japanese parliaments ,_ ,_ ,_) houses)
   (memb `(,_ oldgolds ,_ snails ,_) houses)
   (next-to `(,_ ,_ ,_ horse ,_) `(,_ kools ,_ ,_ ,_) houses)
   (next-to `(,_ ,_ ,_ fox ,_) `(,_ chesterfields ,_ ,_ ,_) houses)
   (memb `(,_ ,_ water ,_ ,_) houses)
   (memb `(,_ ,_ ,_ zebra ,_) houses)))


(define (next-to house-a house-b houses)
  (conde ((on-right house-a house-b houses))
         ((on-right house-b house-a houses))))

;; a2 is at the right of a1
(define (on-right a1 a2 a3)
  (conde
   ((== a3 `(,a1 ,a2 . ,_)))
   ((fresh (cdr-houses)
           (== a3 `(,_ . ,cdr-houses))
           (on-right a1 a2 cdr-houses)
           ))))

;; item is in ls
(define (memb item ls)
  (conde
   ((== ls `(,item . ,_)))
   ((fresh (rest)
           (== ls `(,_ . ,rest))
           (memb item rest)))))

(run* (h) (zebra h))

;; '(((norwegian kools water fox yellow)
;;    (ukrainian chesterfields tea horse blue)
;;    (englishman oldgolds milk snails red)
;;    (spaniard luckystrikes oj dog ivory)
;;    (japanese parliaments coffee zebra green)))
