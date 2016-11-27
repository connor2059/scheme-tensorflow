#lang racket
(require "variable.rkt" "operator.rkt")
(provide (all-defined-out))

(define (L2-loss y-target y-hat loss)
  (let* ((diff (make-variable)))
    (sub-op y-target y-hat diff)
    (square-op diff loss)))
