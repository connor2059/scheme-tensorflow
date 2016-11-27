#lang racket
(require "variable.rkt")
(provide (all-defined-out))

(define (log name var)
  (display name)
  (display ":")
  (display (get-value var))
  (display "\n"))