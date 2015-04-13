(define-structure response code content-type content-body)

(define render-html-file
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
     (make-response 200 '(("Content-Type" . "text/html")) (render-html-file content-body))
     (if
      (equal? content-type "json")
      (make-response 200 '(("Content-Type" . "application/json")) content-body)
      '()))))
