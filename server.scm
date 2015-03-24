
(load (spheres/net sack-server))
(load (spheres/net/sack uri))
(load (spheres/algorithm list))

(define-structure route path f)
(define-structure response code content-type content-body)

(define routes '())

(define HttpResponse
  (lambda (content-type content-body)
    (if
     (equal? content-type "html")
     (make-response 200 '(("Content-Type" . "text/html")) content-body)
     (if
      (equal? content-type "json")
      (make-response 200 '(("Content-Type" . "application/json")) content-body)
      '()))))

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


;Registrar las rutas

(route-register "/" (lambda (env)
		      (HttpResponse "json" "{'name': 'Pablo Fernandez'}")))

(route-register "/hello" (lambda (env)
			   (HttpResponse "html" "<h1>Hello world</h1>")))


(sack-start!
 (lambda (env)
   (let ((ret #t) (res (router (uri-path (env 'sack:uri)) env)))
     (values (response-code res)
	     (response-content-type res)
             (lambda ()
               (and
                ret
                (begin
                  (set! ret #f)
                  (with-output-to-u8vector
                   (list char-encoding: 'UTF-8)
                   (lambda ()
		     (print (response-content-body res))
		     ))))))))
 port-number: 3005)


(thread-sleep! +inf.0)
