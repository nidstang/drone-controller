(define-structure response code content-type content-body)

(define render-static-file
  (lambda (filename)
    (list->string
     (call-with-input-file filename
       (lambda (port)
	 (let f ((x (read-char port)))
	   (if (eof-object? x)
	       '()
	       (cons x (f (read-char port))))))))))


(define HttpResponse
  (lambda (content-type content-body)
    (if
     (equal? content-type "html")
     (make-response 200 '(("Content-Type" . "text/html")) (render-static-file content-body))
     (if
      (equal? content-type "json")
      (make-response 200 '(("Content-Type" . "application/json")) content-body)
      '()))))


(define HttpResponseJS
  (lambda (filename)
    (make-response 200 '(("Content-Type" . "text/javascript")) (render-static-file (string-append "js/" filename)))))
