
(load (spheres/net sack-server))
(load (spheres/net/sack uri))
(load "router.scm")
(load "http.scm")
(load "gamsock/gamsock.o1")



;Registrar las rutas

(route-register "/ss" (lambda (env)
		      (HttpResponse "json" "{'name': 'Pablo Fernandez'}")))

(route-register "/" (lambda (env)
		      (HttpResponse "html" "index.html")))

(route-register "/test" (lambda (env)
			  (HttpResponse "html" "<h1>Test page</h1>")))


;Register of static files
(route-register "/js/jquery.js"
		(lambda (env)
		  (HttpResponseJS "jquery.js")))
(route-register "/js/AjaxHelper.js"
		(lambda (env)
		  (HttpResponseJS "AjaxHelper.js")))


;Rutas for Ajax with json response
(route-register "/api/start" (lambda (env)
			   (HttpResponse "json" "{'response': 'success'}")))

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
