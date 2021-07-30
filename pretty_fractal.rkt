#lang racket
;CSC-316
; Jon Ellch
; Assignment 6, Problem 3 - Koch Curve
; This is really neat, you should check out the slight variation
; i found that makes an ever prettier picture. all of the releveant
; lines are commented in the C-Curve function

(require (lib "graphics.ss" "graphics"))
;


; I just made these so that i didnt get really frustrated debugging
(define proper-make-posn
  (lambda (x y)
  ; (make-posn x (- 400 y))
    (make-posn x y)
  )
 )

(define proper-posn-x
  (lambda (a)
    (posn-x a)
    )
 )

(define proper-posn-y
  (lambda (a)
    ;(- 400 (posn-y a))
    (posn-y a)
    )
  )

(define compute-color
  (lambda (x1 y1 x2 y2)
    (letrec (
             ; pretty one 
             (R (* (abs (sin (+ x1 x2 ))) 0.75))
              (G (* (abs (sin (+ y1 y2 0.8))) 0.55))
              (B (abs (sin (+ x1 y2))))
              
             ; Cool color scheme 
             ; (R (* (abs (sin (/ (+ y1 y2 )) )) 0.75))
             ; (G (* (abs (sin (+ y1 y2 0.8))) 0.25))
             ; (B (* (abs (sin (+ x1 x2 0.6))) 0.75))
              )
              
      
      (make-rgb R G B)
     )
    )
  )


; ---------------------------- C - Curve Scheme -------------------------
(define C-Curve 
  (lambda (my-line-drawer x1 y1 x2 y2 p)
    (letrec ( (x3 (/  (+ (+ x1 x2) (- y1 y2))  2)  ) (y3 (/ (- (+ (+ x2 y1) y2) x1) 2)) )
      
    (cond ( (= p 0) (my-line-drawer (proper-make-posn x1 y1) (proper-make-posn x2 y2) (compute-color x1 y1 x2 y2)) )
          (else 
        
          ; I suggest uncommenting this line to make the whole thing more aesthetically pleasing.
        ; (my-line-drawer (proper-make-posn x1 y1) (proper-make-posn x2 y2) (compute-color x1 y1 x2 y2))
        
         ; (my-line-drawer (proper-make-posn x1 y1) (proper-make-posn x3 y3))
         ;  (my-line-drawer (proper-make-posn x2 y2)  (proper-make-posn x3 y3))
         ;   (print "X1 : ") (print x1) (print " Y1 : ") (print y1) (newline)
          ; (print "X2 : ") (print x2) (print " Y2 : ") (print y2) (newline)
           ; (print "X3 : ") (print x3) (print " Y3 : ") (print y3) (newline)
           
           ; These two lines do a proper C-Curver
          ; (C-Curve my-line-drawer x1 y1 x3 y3  (- p 1))
          ; (C-Curve my-line-drawer  x3 y3 x2 y2  (- p 1))

           ;These two lines do another pretty curve ive dubbed the 'cache curve' >:>
          (C-Curve my-line-drawer x1 y1 x3 y3   (- p 1))
          (C-Curve my-line-drawer   x2 y2  x3 y3 (- p 1))
           
           )
          )
      )
    )
  )

(open-graphics)
(define my-viewport (open-viewport "C Curve Fun" 600 600))
(define my-rectangle-drawer (draw-solid-rectangle my-viewport))
(define my-line-drawer (draw-line my-viewport))
(C-Curve my-line-drawer 300 450 300 250 12)

