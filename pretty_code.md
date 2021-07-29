```
;CSC-316
; Jon Ellch
; Assignment 6, Problem 3 - Koch Curve
; This is really neat, you should check out the slight variation
; i found that makes an ever prettier picture. all of the releveant
; lines are commented in the C-Curve function

; These two lines do a proper C-Curver
; (C-Curve my-line-drawer x1 y1 x3 y3 (- p 1))
; ( C-Curve my-line-drawer x3 y3 x2 y2 (- p 1))

;These two lines do another pretty curve ive dubbed the 'cache curve' >:>
;(C-Curve my-line-drawer x1 y1 x3 y3 (- p 1))
;(C-Curve my-line-drawer x2 y2 x3 y3 (- p 1))

(require (lib "graphics.ss" "graphics"))
;
; ---------------------------- C - Curve Scheme -------------------------
(define C-Curve 
  (lambda (line-drawer x1 y1 x2 y2 p)
    (letrec ( (x3 (/  (+ (+ x1 x2) (- y1 y2))  2)  ) (y3 (/ (- (+ (+ x2 y1) y2) x1) 2)) )
      
    (cond ( (= p 0) (my-line-drawer (proper-make-posn x1 y1) (proper-make-posn x2 y2) (compute-color x1 y1 x2 y2)) )
          (else 
        
           ; These two lines do a proper C-Curver
           (C-Curve my-line-drawer x1 y1 x3 y3  (- p 1))
           (C-Curve my-line-drawer  x3 y3 x2 y2  (- p 1))

           
           )
          )
      )
    )
  )

```
(open-graphics)
(define my-viewport (open-viewport "C Curve Fun" 600 600))
(define my-rectangle-drawer (draw-solid-rectangle my-viewport))
(define my-line-drawer (draw-line my-viewport))
(C-Curve my-line-drawer 300 450 300 250 12)
;(C-Curve my-line-drawer  450 450 450 250 10)
