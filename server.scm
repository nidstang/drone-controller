(load (spheres/net sack-server))
(load (spheres/net/sack uri))
(load (spheres/algorithm list))

(define-structure route path f)
(define routes '())

(define route-register
  (lambda (path f)
    (set! routes (cons* (make-route path f) routes))))

(define router
  (lambda (route env)
    (let recur ((rest routes))
      (if (null? rest)
	  '()
	  (begin
	    (if (equal? (route-path (car rest)) route)
		((route-f (car rest)) env)
		(recur (cdr rest))))))))

(route-register "/hello"
		(lambda (env)
		  (print "Hello World")))

(sack-start!
 (lambda (env)
   (let ((ret #t))
     (values 200
	     '(("Content-Type" . "application/json"))
             (lambda ()
               (and
                ret
                (begin
                  (set! ret #f)
                  (with-output-to-u8vector
                   (list char-encoding: 'UTF-8)
                   (lambda ()
		     ;(write (env 'sack:uri))
		     ;(print "{'name': 'Pablo Fernandez'}")
		     ;(pp (uri-path (env 'sack:uri)))
		     (router (uri-path (env 'sack:uri)) env)
		     ))))))))
 port-number: 3000)


(thread-sleep! +inf.0)
