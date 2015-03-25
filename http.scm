(define-structure response code content-type content-body)

(define HttpResponse
  (lambda (content-type content-body)
    (if
     (equal? content-type "html")
     (make-response 200 '(("Content-Type" . "text/html")) content-body)
     (if
      (equal? content-type "json")
      (make-response 200 '(("Content-Type" . "application/json")) content-body)
      '()))))