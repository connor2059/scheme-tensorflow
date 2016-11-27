(define (make-variable)
  (let ((value 0)
        (forward '()))
    (define (call-each actions)
      (if (null? actions)
          'done
          (begin
            ((car actions))
            (call-each (cdr actions)))))
;  
    (define (set-value! new-value)
      (set! value new-value)
      (call-each forward))
    (define (add-forward! proc)
      (set! forward (cons proc forward)))
;      
    (define (dispatch m)
      (cond ((eq? m 'get-value) value)
            ((eq? m 'set-value!) set-value!)
            ((eq? m 'add-forward!) add-forward!)
            (else (display "error"))))
    dispatch))

(define (get-value v)
  (v 'get-value))
(define (set-value! v new-value)
  ((v 'set-value!) new-value))
(define (add-forward! v proc)
  ((v 'add-forward!) proc))

(define (add-op in-1 in-2 out)
  (define (operator)
    (let ((new-value (+ (get-value in-1)
                        (get-value in-2))))
      (set-value! out new-value)))
  
  (add-forward! in-1 operator)
  (add-forward! in-2 operator))

(define x (make-variable))
(define y (make-variable))
(define z (make-variable))
(define f (make-variable))

;(add-op x y z)

(define (add-triple in-1 in-2 in-3 out)
  (let ((q (make-variable)))
    (add-op in-1 in-2 q)
    (add-op q in-3 out)))

(add-triple x y z f)

(set-value! x 10)
(set-value! y 1)
(set-value! z 1)
(get-value f)
