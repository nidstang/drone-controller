
(load (spheres/net sack-server))
(load (spheres/net/sack uri))
(load "router.scm")
(load "http.scm")
(load "ar-drone/atcommand.scm")
(load "ar-drone/udp-control.scm")



;Registrar las rutas

(route-register "/ss" (lambda (env)
		      (HttpResponse "json" "{\"name\": \"Pablo Fernandez\"}")))

(route-register "/" (lambda (env)
		      (HttpResponse "html" "index.html")))

(route-register "/canvas" (lambda (env)
		      (HttpResponse "html" "canvas.html")))

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
(route-register "/api/config" (lambda (env)
				(send-commands (create-altitudemax-command 2))
				(HttpResponse "json" "{\"response\": \"success\", \"message\": \"Configuration drone\"}")))

(route-register "/api/rotate-left" (lambda (env)
				     (send-commands (create-pcmd command/pcmd/Rleft 0.5))
				     (HttpResponse "json" "{\"response\": \"success\", \"message\": \"To left\"}")))

(route-register "/api/rotate-right" (lambda (env)
				      (send-commands (create-pcmd command/pcmd/Rright 0.5))
				      (HttpResponse "json" "{\"response\": \"success\", \"message\": \"To right\"}")))

(route-register "/api/takeoff" (lambda (env)
				(send-commands (create-action command/action/takeoff))
				(HttpResponse "json" "{\"response\": \"success\", \"message\": \"Drone take off\"}")))
(route-register "/api/landing" (lambda (env)
				(send-commands (create-action command/action/landing))
				(HttpResponse "json" "{\"response\": \"success\", \"message\": \"Drone landing\"}")))

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
