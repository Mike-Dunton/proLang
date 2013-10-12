;
; <bits> -> 0 <bits>
; <bits> -> 1 <bits>
; <bits> -> empty
;

(define bits
  (lambda (arg)
		(cond
			((equal? arg ())                     #t)
			((equal? '0 (car arg)) (bits (cdr arg)))
			((equal? '1 (car arg)) (bits (cdr arg)))
			(else                     (cons #f arg))
		)
	)
)
