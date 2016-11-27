#lang racket
(require "variable.rkt" "operator.rkt")
(provide (all-defined-out))

(define (Linear in w b out)
  (let ((z (make-variable)))
    (mul-op in w z)
    (add-op z b out)))