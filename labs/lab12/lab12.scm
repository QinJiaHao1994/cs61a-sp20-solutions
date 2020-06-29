; Lab 14: Final Review
(define (compose-all funcs)
  (define s funcs)
  (define (_compose x _funcs)
    (if (null? _funcs)
        x
        (_compose ((car _funcs) x) (cdr _funcs))
    )
  )
  (define (compose x) (_compose x s))
  compose
)
