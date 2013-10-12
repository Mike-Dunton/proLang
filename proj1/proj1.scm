;
;BOR
;
(define BOR
	(lambda (x y)
		(cond
			((equal? x #t)		#t)
			((equal? y #t)    #t)
			(else             #f))))
;
;BAND
;
(define BAND
	(lambda (x y)
		(cond
			((equal? x #f) #f)
			((equal? y #f) #f)
			(else					#t))))

;
;pos?
;
(define POS?
	(lambda (x)
		(if (> x 0) #t #f)))

;
;in?
;
(define in?
	(lambda (needle haystack)
		(cond
			((equal? haystack ()) 	        #f)
			((equal? needle (car haystack))	#t)
			(else (in? needle (cdr haystack)) )
		)
	)
)

;
;reduce
;

(define reduce
	(lambda (operator operands)
		(cond 
		  ((equal? (cdr operands) ()) (car operands)) 
			((equal? (cdr (cdr operands)) ())  (operator (car operands) (car (cdr operands))) )
			(else (operator (car operands) (reduce operator (cdr operands))))
		)
	)
)

;
;filter
;input: function that returns true or false like in? or noun?
;output: a list of atoms that meet the requirements of the input function
(define filter
	(lambda (pred lis)
		(cond
			((equal? lis ()) '())
			((pred (car lis)) (cons (car lis) (filter pred (cdr lis))))
			(else (filter pred (cdr lis)))
		)
	)
)

;
;DEFINE WORD LISTS
;
(define determiners '(a an the))
(define nouns '(apple bicycle car cow dog fox motorcycle path pie road truck))
(define adjectives '(black brown fast hairy hot quick red slow))
(define verbs '(commutes destroys drives eats jumps makes occupies rides stops travels walks))
(define prepositions '(around at of on over to under))


;det? noun? verb? adj? perp?
;input: single atom
;output: #t if the input is an atom in the respective Word List
;output: #f otherwise or if word passed in is null
(define det?
	(lambda (word)
		(cond
			((null? word) #f)
			(else (in? word determiners))
		)
	)
)

(define noun?
	(lambda (word)
		(cond
			((null? word) #f)
			(else (in? word nouns))
		)
	)
)
(define verb?
	(lambda (word)
		(cond
			((null? word) #f)
			(else (in? word verbs))
		)
	)
)
(define adj?
	(lambda (word)
		(cond
			((null? word) #f)
			(else (in? word adjectives))
		)
	)
)
(define prep?
	(lambda (word)
		(cond
			((null? word) #f)
			(else (in? word prepositions))
		)
	)
)

;
;OK?
;input: list of atoms
;output #f if more than 25% of the words in input are adjectives
;output #t if no more than 25% of the words in input are adjectives
(define OK
	(lambda (wordList)
		(if 
			(>  
				(/ 
					(length (filter adj? wordlist)) 
					(length wordList)
				) 
			  (/ 1 4)
			)
		#f #t)
	)
)
;
;det
;input: wordlist
;output: a list minus the first word if it is a det
;output: an empty list if the first word is not a det
(define det
	(lambda (wordList)
		(if (det? (car wordList)) (cdr wordList) '())
	)
)

(define  noun
	(lambda (wordList)
	 (if (noun? (car wordList)) (cdr wordList) '())
	)
)
(define verb
	(lambda (wordList)
		(if (verb? (car wordList)) (cdr wordList) '())
	)
)
(define adj
	(lambda (wordList)
		(if (adj? (car wordList)) (cdr wordList) '())
	)
)
(define prep
	(lambda (wordList)
		(if (prep? (car wordList)) (cdr wordList) '())
	)
)

(define nounphrase1
	(lambda (wordList)
		(cond 
			((det? (car wordList)) (nounphrase1 (det wordList)))
			(else (nounphrase2 wordList))
		)
	)
)

(define nounphrase2
	(lambda (wordList)
		(cond
			((adj? (car wordList))  (nounphrase2 (adj wordList)))
			((noun? (car wordList)) (noun wordList))
			(else                  (cons #f  wordList))
		)
	)
)

(define verbphrase
	(lambda (wordList)
		(cond
			((null? wordList) '())
			((verb? (car wordList)) (verbphrase  (verb wordList)))
			((prep? (car wordList)) (nounphrase1 (prep wordList)))
			((equal? (car (nounphrase1 wordList)) #f) wordList) 
			(else (nounphrase1 wordList))
		)
	)
)

(define sentence
	(lambda (wordList)
		(verbphrase (nounphrase1 wordList))
	)
)
