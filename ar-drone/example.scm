(load "atcommand.scm")
(load "udp-control.scm")

; Altitude max set to 2 meters
(print (create-altitudemax-command 2))


; Set action for drone takeoff
(send-commands (create-action command/action/takeoff))


; Now, we will send pcmd commands
(send-commands (create-pcmd command/pcmd/up 0.5))


;We can also send multiple commands at once
(define commands '())
(define config (create-altitudemax-command 2))
(define takeoff (create-action command/action/takeoff))

(set! commands (cons config (cons takeoff commands)))

(send-commands commands)
