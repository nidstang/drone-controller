(load "ar-drone/constants.scm")

(define sequence 0)

; Invert or not (flag -> #t)
(define invert
  (lambda (value flag)
    (if flag
	(* value -1)
	value)))

;Convert a value (returned by generate-pcmd-command) to formatted string
(define serialize-lst-pcmd
  (lambda (lst)
    (let recur ((rest lst) (cmd "") (count 4))
      (if (not (null? rest))
	  (begin (set! cmd (string-append cmd (number->string (car rest)) (if (> count 0) "," "")))
		 (recur (cdr rest) cmd (- count 1)))
	  cmd))))

; (0 0 0 0 0)
;  ' ' ' ' '
;  ' ' ' ' '
;  ' ' ' ' - - - - - - - - - - - - Clock (Rotatition with negative or positvie speed)
;  ' ' ' - - - - - - - - - - - - - Up (positive speed) or Down (negative speed)
;  ' ' - - - - - - - - - - - - - - Forward (negative speed) or Backward (positve speed)
;  ' - - - - - - - - - - - - - - - Rignt (positive speed) or Left (negative speed)
;  - - - - - - - - - - - - - - - - Flag: Default -> 1

(define generate-pcmd-command
  (lambda (type speed)
    (let recur ((lst '()) (count 4))
      (if (= count 0)
	  (cons '1 lst)
	  (if (= (speed/position-index type) count)
	      (recur (cons (invert speed (speed/position-invert type)) lst) (- count 1))
	      (recur (cons '0 lst) (- count 1)))))))


;API

;Create a PCMD with the type and the speed passed
;Output example: AT*PCMD=1,1,0,0,0.5,0

(define create-pcmd
  (lambda (type speed)
    (set! sequence (+ sequence 1))
    (let* ((pcmd-lst (generate-pcmd-command type speed)))
      (string-append command/header command/pcmd (number->string sequence) "," (serialize-lst-pcmd pcmd-lst)))))

;Create a Action command with the type
;Output example: AT*REF=1,290718208

(define create-action
  (lambda (type)
    (set! sequence (+ sequence 1))
    (string-append command/header command/action (number->string sequence) "," type)))

;Command for altitude max (meters). Note: sequence must be 1.

(define create-altitudemax-command
  (lambda (altitude)
    (set! sequence (+ sequence 1))
    (let* ((alt (* altitude 1000)))
      (string-append command/header command/config (number->string sequence) "," "\"control:altitude_max\",\"" (number->string alt) "\""))))



