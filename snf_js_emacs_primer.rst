*********************************
Emacs JS Primer
*********************************


``js2-mode``
=================================

This is an emacs package available via the standard ``package*`` commands at the
Melpa repository. You need to add one line to ``init.el`` to configure it:

.. code-block:: lisp

                (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


This adds much nicer auto-formatting behavior and auto-linting than the built in
emacs defaults.


REPL Fixes
=================================

A vanilla Node REPL inside an emacs ``shell`` process includes garbage
(unicode?) characters instead of the standard ``>`` prompt. Add this to
``init.el`` to fix that:

.. code-block:: lisp

                (setenv "NODE_NO_READLINE" "1")


``js-comint``
=================================

This package simplifies the use of Node in emacs, so you get a live connection
between REPL and code windows, like ``CIDER`` or ``elpy``, as opposed to just
running Node inside a shell. Install it with ``M-x package-install``, then
configure ``init.el`` like so:

.. code-block:: lisp

                (require 'js-comint) 

                (setq inferior-js-program-command "node") ;; not "node-repl"

                ;; could also use 'js3-mode-hook here
                (add-hook 'js2-mode-hook '(lambda () 
                    (local-set-key "\C-x\C-e" 
                                'js-send-last-sexp)
                    (local-set-key "\C-\M-x" 
                                'js-send-last-sexp-and-go)
                    (local-set-key "\C-cb" 
                                'js-send-buffer)
                    (local-set-key "\C-c\C-b" 
                                'js-send-buffer-and-go)
                    (local-set-key "\C-cl" 
                                'js-load-file-and-go)))


NB: any time >1 letter follows a control key (``C`` or ``M``), only the *first*
letter is paired with the control key. The remaining letters are to be typed as
separate keystrokes *without* the control key. In *my* notes I spread that out,
as in ``C-x l`` to count lines. But the arguments in ``init.el`` must be clumped
together, as in ``C-xl``. So the ``C-cl`` binding above (``load-file-and-go``)
is actually invoked by ``C-c l``. Note that *everything* is squished together
above; there's no space in ``C-x\C-e`` either. 

jade-mode
=================================

Finally, you'll probably want code highlighting for ``jade``, since it's the
default template language for ``Express``, the most-common Node web framework.
There's a ``jade-mode.el`` installable via ``package``, or you could do a manual
install to ``~/.emacs.d/vendor`` from github. Configuration is just a few more
lines in ``init.el``.

.. code-block:: lisp

    ;; jade-mode @ https://github.com/brianc/jade-mode
    ;; (add-to-list 'load-path "~/.emacs.d/vendor/jade-mode")
    (require 'jade-mode)
    (add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

Where the two commented-out lines are only relevent if you're going for a manual
installation. If installed via ``package``, the final two modes are all you
need. 

