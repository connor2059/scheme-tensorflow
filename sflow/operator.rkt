#lang racket
(require "variable.rkt")
(provide (all-defined-out))

(define (add-op in-1 in-2 out)
  (define (operator)
    (let ((new-value (+ (get-value in-1)
                        (get-value in-2))))
      (set-value! out new-value)))
  (define (take-grad)
    (let ((new-grad (get-grad out)))
      (set-grad! in-1 new-grad)
      (set-grad! in-2 new-grad)))
  
  (add-forward! in-1 operator)
  (add-forward! in-2 operator)

  (add-backward! out take-grad))

(define (sub-op in-1 in-2 out)
  (define (operator)
    (let ((new-value (- (get-value in-1)
                        (get-value in-2))))
      (set-value! out new-value)))
  (define (take-grad)
    (let ((new-grad (get-grad out)))
      (set-grad! in-1 new-grad)
      (set-grad! in-2 (* -1 new-grad))))
  
  (add-forward! in-1 operator)
  (add-forward! in-2 operator)

  (add-backward! out take-grad))

(define (mul-op in-1 in-2 out)
  (define (operator)
    (let ((new-value (* (get-value in-1)
                        (get-value in-2))))
      (set-value! out new-value)))

  (define (take-grad)
    (let* ((out-grad (get-grad out))
          (in-1-grad (* (get-value in-2) out-grad))
          (in-2-grad (* (get-value in-1) out-grad)))
      (set-grad! in-1 in-1-grad)
      (set-grad! in-2 in-2-grad)))
    
  (add-forward! in-1 operator)
  (add-forward! in-2 operator)

  (add-backward! out take-grad))

(define (square-op in out)
  (define (operator)
    (let ((new-value (* (get-value in)
                        (get-value in))))
      (set-value! out new-value)))

  (define (take-grad)
    (let* ((out-grad (get-grad out))
           (in-grad (* (* 2 (get-value in))
                       out-grad)))
      (set-grad! in in-grad)))
    
  (add-forward! in operator)

  (add-backward! out take-grad))
