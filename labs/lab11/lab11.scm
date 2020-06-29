(define (flatten x)
  (cond 
    ((null? x)
     nil
    )
    ((pair? x)
     (append (flatten (car x)) (flatten (cdr x)))
    )
    (else
     (list x)
    )
  )
)

(define (flatmap f x)
  (if (null? x)
      nil
      (flatten (cons (f (car x)) (flatmap f (cdr x))))
  )
)

(define (expand lst)
  (define (f x)
    (cond 
      ((equal? x 'x) '(x r y f r))
      ((equal? x 'y) '(l f x l y))
      (else          x)
    )
  )
  (flatmap f lst)
)

(define (apply l idx)
  (if ((zero? idx) ((car l)))
      (apply (cdr l) (- idx 1))
  )
)

(define (helper instr dist x)
  (if (null? instr)
      nil
      (helper (cdr instr) dist ((car instr) dist))
  )
)

(define (interpret instr dist)
  (helper instr dist 0)
)

(define (apply-many n f x)
  (if (zero? n)
      x
      (apply-many (- n 1) f (f x))
  )
)

; (define (dragon n d)
;   (interpret (apply-many n expand '(f x)) d)
; )
(define (dragon n d) (apply-many n expand '(f x)))
