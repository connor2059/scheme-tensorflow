#lang racket
(require "sflow/variable.rkt"
         "sflow/operator.rkt"
         "sflow/layer.rkt"
         "sflow/loss.rkt"
         "sflow/optim.rkt"
         "sflow/log.rkt")
  
(define x (make-variable))
(define y-target (make-variable))

(define w1 (make-variable))
(define b1 (make-variable))
(define w2 (make-variable))
(define b2 (make-variable))

(define layer1 (make-variable))
(define y-hat (make-variable))
(define loss (make-variable))

(Linear x w1 b1 layer1)
(Linear layer1 w2 b2 y-hat)
(L2-loss y-target y-hat loss)

(set-value! x 10)
(set-value! y-target 4)

(set-value! w1 1)
(set-value! b1 0.5)
(set-value! w2 5)
(set-value! b2 0.7)

(gradient-descent loss (list w1 b1 w2 b2) 0.0001 20)

(log "y-hat" y-hat)
(log "w1" w1)
(log "b1" b1)
(log "w2" w2)
(log "b2" b2)
