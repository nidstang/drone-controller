(load (spheres/algorithm list))
(define-structure route path f)
(define routes '())
(define js-path "js")

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

(define dispatcher-javascript-file
  (lambda (filename)
    (string-append "/js/" filename)))
