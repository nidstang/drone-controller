(define-structure speed/position index invert)

(define command/header "AT*")
(define command/config "CONFIG=")
(define command/action "REF=")
(define command/pcmd "PCMD=")

(define command/pcmd/up
  (make-speed/position 3 #f))
(define command/pcmd/down
  (make-speed/position 3 #t))
(define command/pcmd/forward
  (make-speed/position 2 #t))
(define command/pcmd/backward
  (make-speed/position 2 #f))
(define command/pcmd/Rleft
  (make-speed/position 4 #t))
(define command/pcmd/Gleft
  (make-speed/position 1 #t))
(define command/pcmd/Rright
  (make-speed/position 4 #f))
(define command/pcmd/Grigth
  (make-speed/position 1 #f))

(define command/action/takeoff "290718208")
(define command/action/landing "290717696")
(define command/action/reset "290717952")
