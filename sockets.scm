(load "gamsock/gamsock.o1")

;I define a UDP socket
(define socket (create-socket address-family/internet socket-type/datagram))

;Now, I define the destination source IP
(define inaddr (internet-address->socket-address '#u8(192 168 1 1) 3000))

;Method for send something to the socket
(define sendTo
  (lambda (data)
    (send-message socket data 0 #f 0 inaddr)))
