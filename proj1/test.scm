 (lambda (operation params)
                  (if( < (length params) 2 ) 
									                    (car params)
																			                    (let ((firstNum (car params)) (secondNum (car (cdr params))) (remaining (cdr (cdr params))))
																													                    (reduce operation (cons (operation firstNum secondNum) remaining))
																																							                      )
																																																		                    )
																																																												                 )
																																																																				   )