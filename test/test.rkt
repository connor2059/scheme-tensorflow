#lang racket
(require "variable.rkt"
         "operator.rkt"
         "layer.rkt"
         "loss.rkt"
         "optim.rkt"
         "log.rkt")
  
(define x (make-variable))
(define w (make-variable))
(define b (make-variable))
(define y-hat (make-variable))
(define y-target (make-variable))
(define loss (make-variable))

(Linear x w b y-hat)
(L2-loss y-target y-hat loss)

(set-value! x 10)
(set-value! w 1)
(set-value! b 0.5)
(set-value! y-target 4)

(gradient-descent loss (list w b) 0.001 20)

(log "w" w)
(log "b" b)
(log "y-hat" y-hat)
