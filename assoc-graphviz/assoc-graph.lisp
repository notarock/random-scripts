
(defparameter *wiz-nodes* '((living-room (You are in the living room.
                                          a wizard is on the couch.))
                            (garden (You are in a beautiful garden.
                                     there is a well in front of you))
                            (attic (You are in the attic.
                                    There is a giant welding torch in the corner.))))

(defparameter *wiz-edges* '((living-room (garden west door)
                             (attic upstairs ladder))
                            (garden (living-room east door))
                            (attic (living-room downstairs ladder))))

(defparameter *max-label-length* 30)

(defun dot-name (exp)
  (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))

(defun dot-label (exp)
  (if exp
      (let ((s (write-to-string exp :pretty nil)))
        (if (> (length s) *max-label-length*)
            (concatenate 'string (subseq s 0 (- *max-label-length* 3)) "...")
            s))
      ""))

(defun nodes->dot (nodes)
  (mapc (lambda (node)
          (fresh-line)
          (princ (dot-name (car node)))
          (princ "[label=\"")
          (princ (dot-label node))
          (princ "\"];"))
        nodes))

(defun edges->dot (edges)
  (mapc (lambda (node)
          (mapc (lambda (edge)
                  (fresh-line)
                  (princ (dot-name (car node)))
                  (princ "->")
                  (princ (dot-name (car edge)))
                  (princ "[label=\"")
                  (princ (dot-label (cdr edge)))
                  (princ "\"];"))
                (cdr node)))
        edges))

(defun graph->dot (nodes edges)
  (princ "digraph{")
  (nodes->dot nodes)
  (edges->dot edges)
  (princ "}"))

(defun dot->png (fname thunk)
  (with-open-file (*standard-input*
                   fname
                   :direction :output
                   :if-exists :supersede)
    (funcall thunk))
  (uiop:run-program (concatenate 'string "dot -Tpng -O " fname)))

(defun graph->png (fname nodes edges)
  (dot->png fname
            (lambda ()
              (graph->dot nodes edges))))


