; ; Scheme ;;
(define (over-or-under a b)
  (cond 
    ((< a b) -1)
    ((= a b) 0)
    (else    1)
  )
)

; ;; Tests
(over-or-under 1 2)

; expect -1
(over-or-under 2 1)

; expect 1
(over-or-under 1 1)

; expect 0
(define (filter-lst fn lst)
  (cond 
    ((null? lst)
     nil
    )
    ((fn (car lst))
     (cons (car lst) (filter-lst fn (cdr lst)))
    )
    (else
     (filter-lst fn (cdr lst))
    )
  )
)

; ;; Tests
(define (even? x) (= (modulo x 2) 0))

(filter-lst even? '(0 1 1 2 3 5 8))

; expect (0 2 8)
(define (make-adder n)
  (define (adder m) (+ m n))
  adder
)

; ;; Tests
(define adder (make-adder 5))

(adder 8)

; expect 13
; ; Extra questions
(define lst '((1) 2 (3 4) 5))

(define (composed f g) (define (t x) (f (g x))) t)

(define (remove item lst)
  (filter-lst (lambda (x) (not (= item x))) lst)
)

; ;; Tests
(remove 3 nil)

; expect ()
(remove 3 '(1 3 5))

; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))

; expect (3 1 4 4)
(define (no-repeats s)
  (if (null? s)
      s
      (cons (car s)
            (filter (lambda (x) (not (eq? (car s) x)))
                    (no-repeats (cdr s))
            )
      )
  )
)

(define (substitute s old new)
  (if (null? s)
      s
      (cons (if (pair? (car s))
                (substitute (car s) old new)
                (if (equal? (car s) old)
                    new
                    (car s)
                )
            )
            (substitute (cdr s) old new)
      )
  )
)

(define (sub-all s olds news)
  (if (null? olds)
      s
      (sub-all (substitute s (car olds) (car news))
               (cdr olds)
               (cdr news)
      )
  )
)
