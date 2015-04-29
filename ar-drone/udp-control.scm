(load "ar-drone/gamsock/gamsock.o1")
(load "ar-drone/configuration.scm")
(load (spheres/string u8vector))

(define-structure connection socket inaddr)
(define udp-connection
  (make-connection
   (create-socket address-family/internet socket-type/datagram)
   (internet-address->socket-address IP PORT)))


(define send-commands
  (lambda (cmds)
    (if (list? cmds)
	(let recur ((rest cmds) (str-command ""))
	  (if (not (null? rest))
	      (begin
		(set! str-command (string-append str-command (car rest) "\r"))
		(recur (cdr rest) str-command))
	      (begin
		(send-message
		 (connection-socket udp-connection)
		 (string->u8vector str-command) 0 #f 0
		 (connection-inaddr udp-connection)))))
	(send-message
	 (connection-socket udp-connection)
	 (string->u8vector (string-append cmds "\r")) 0 #f 0
	 (connection-inaddr udp-connection)))))


