#lang racket
(require "variable.rkt" "operator.rkt" "log.rkt")
(provide (all-defined-out))

(define (gradient-descent loss parms step iters)
  (define (update-parms! loss parms step)
    (set-grad! loss 1)
    (map (lambda (p)
           (let* ((delt-p (* step (get-grad p)))
                  (new-p (- (get-value p) delt-p)))
             (set-value! p new-p)))
         parms))
  
  (define (main-loop iters)
    (if (= iters 0)
        (get-value loss)
        (begin
          (display "iters:")
          (display iters)
          (display " ")
          (log "Loss" loss)
          (update-parms! loss parms step)
          (main-loop (- iters 1)))))

  (main-loop iters))