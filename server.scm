
(load (spheres/net sack-server))
(load (spheres/net/sack uri))
(load "router.scm")
(load "http.scm")


;Registrar las rutas

(route-register "/" (lambda (env)
		      (HttpResponse "json" "{'name': 'Pablo Fernandez'}")))

(route-register "/hello" (lambda (env)
			   (HttpResponse "html" "<h1>Hello</h1>")))

(route-register "/test" (lambda (env)
			  (HttpResponse "html" "<h1>Test page</h1>")))


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
