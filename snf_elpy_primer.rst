*********************************
Elpy Primer
*********************************

`elpy`_ is an Emacs package that aims to create an IDE-like environment for
working with Python. I don't need (or want!) a heavyweight true IDE, but it's
nice to be able to launch connected REPLs and that sort of thing. In an ideal
world I'll end up with something as useful as CIDER is for Clojure, though
that's a high bar; I'll be satisfied if I end up with something half that
useful as CIDER. 

.. _`elpy`: https://github.com/jorgenschaefer/elpy

The modest but acceptable documentation can be found `here`_.

.. _`here`: http://elpy.readthedocs.org/en/latest/introduction.html


Installation
==================

It's not actual found on one of the major emacs repositories (e.g. Melpa), but
you can add the github repository to your ``init.el`` as though it were:

.. code-block:: lisp

   (require 'package)
   (add-to-list 'package-archives
                '("elpy" . "http://jorgenschaefer.github.io/packages/"))

Then with emacs running, it's just ``M-x package-install RET elpy RET``.


Configuration
==================

Initialize it with ``M-x elpy-enable``. At first glance it *seems* like this
needs activating every single time (?).

Persistently change settings with ``M-x elpy-config``. 

From ``elpy-config`` you can set a default virtualenv, but really you're likely
to want this to be different from invocation to invocation. You can use the ``M-x
pyvenv-workon`` command to launch virtualenvs for use inside emacs / with elpy,
**but** note that each venv must have the various ``elpy`` helper packages
available for things to work (e.g. ``jedi``, ``flake8``, ``autopep8``, and
``pytest`` at a minimum). 

It doesn't seem like the default virtualenv is actually remembered! You might
need to run ``pyvenv-workon`` every single time. TODO: investigate further.


Missing Packages
---------------------------------

Several packages are *not* installed by default when you install ``elpy``
itself, but you will definitely want them available. They are all installed via
``pip``, and they must be available in the currently-enabled venv.

In any case, here are some of the the packages that elpy can use if they're available:

- jedi        for autocompletion
- autopep8    for linting
- flake8      for syntax checking
- pytest      as a testrunner
- importmagic for messing with imports 
  
Sure enough, after setting the default venv and then installing those packages
into that ven, ``elpy-config`` stopped complaining about them being missing. I'm
assuming there may be trouble with this down the line!

I can see where this could get complicated: the docs explicitly say that you
*can* have one venv set as the default for ``elpy`` but then run
``pyvenv-workon`` or ``pyvenv-activate`` to get a shell inside another venv.
Some quick experimentation confirms this: when you use ``workon`` or
``activate``, if the new venv does not include the packages above, then those
functions are *not* available. So basically if you plan to use these functions
in *any* project, that project *must* include those packages in the venv. 


Session Quickstart
=================================

``M-x elpy-enable``   Seems required each time (?)

``M-x pyvenv-workon name_of_venv`` activates the venv of choice, which should
have jedi, pyflakes, autopep8, etcetera installed, as discussed above.

``C-c C-z`` starts a new Python REPL and background process. This is required
for most of the code help tools to work, since they need to communicate with a
Python process, and there isn't one running until you've done this. So even if
you aren't about to get all interactive in a REPL, you probably want this to be
part of your startup process. AKA ``M-x elpy-shell-switch-to-shell``. 


Interactive Mode
=====================

This, more so than autocompletion or refactoring, is what I'm really after. The
commands are nicely similar to the ones in CIDER: I assume that both draw from
some earlier, well-known mode.

``C-c C-z``  switch to Python REPL buffer, starting one if necessary. Toggles
between REPL and source after the first invocation starts the REPL. 

``C-c C-c`` sends a full source buffer to the REPL, or a complete selected
region if you have one active. AKA ``M-x elpy-shell-send-region-or-buffer``

``C-c RET`` sends one (1) statement to the REPL. AKA ``M-x
elpy-shell-send-current-statement``. 

``C-M-x``   sends nearest/outermost class or function definition to the REPL.
AKA ``M-x python-shell-send-defun``. 

``M-x elpy-rpc-restart``  Restarts the REPL Python process, in case things have
gotten wacky on you. 


Navigation
==============

``C-UP``    Move up one full Python block
``C-DOWN``  Move down one full Python block


Project Features
====================

You'll want to set an active project, which will enable ``lein`` -like behavior,
by which I mean ``elpy`` is aware of which directories to search in beyond just
the CWD. This lets you do project-wide searches for text strings, etcetera.

``C-c C-f``  Finds a file within the project. AKA ``M-x elpy-find-file``.

``C-c C-s``  Grep search within the project. AKA ``M-x elpy-rgrep-symbol``. 


Persistent Setting Of Project Root And Other Variables
----------------------------------------------------------

``M-x elpy-set-project-root`` Set a project root directory on a one-off basis.
But really, this is the sort of thing you want to have happen automatically,
based on the directory you're currently working in! The two variables that need
to be *persistently* set for this to happen are:

- ``elpy-project-root``    (an absolute path from ``~`` to project root)
- ``elpy-project-ignored-directories``  (varies per project)
- ``elpy-test-runner``     (you will always want ``elpy-test-pytest-runner``)

The way to do this is to take advantage of a core emacs feature: directory-local
variables. Emacs looks for a file named ``.dir-locals.el`` any time it opens a
file anywhere. If it finds it, it applies any variable declarations within to
the environment when editing that file. Emacs also looks *up* the hierarchy for
any ``.dir-locals.el`` files *above* the current file, meaning that a dir-local
file works on all files in all child directories.

Rather than manually editing your ``.dir-locals.el`` file, you should use the
command ``M-x add-dir-local-variable`` while editing a top-level file. Then
confirm in a terminal that the new file is created. You need precisely one (1)
such file per project, at the project top and defining the symbol
``elpy-project-root``.

The ``add-dir-local-variable`` command gives you a nice little auto-popup buffer
with the formatted contents of the new ``.dir-locals.el`` file. You need to save
it yourself, but after that emacs should find and load it automatically whenever
you visit any file in that directory and/or any file in any child directory of
that directory.

Here's an example ``.dir-locals.el`` file after using the command to add two
dir-local variables for the ``snf`` project::

.. code-block:: lisp

    ;;; Directory Local Variables
    ;;; For more information see (info "(emacs) Directory Variables")

    ((python-mode
      (elpy-test-runner . elpy-test-pytest-runner)
      (elpy-project-root . ~/code/py/snf/snf)))

The first time I visited a file in that directory, I got a little autopopup
buffer asking me to confirm this as safe, and offering me the choice of
rejecting these variables, accepting them once, or accepting them forever. Nice!


Inspecting Per-Buffer Variable
......................................

``C-h v`` shows the value of any variable. AKA ``M-x describe-variable``. You
can use this to confirm the current value of per-buffer variables such as
``elpy-project-root``, ``elpy-test-runner``, etc.


Syntax Tools
=================

``C-c C-v``  Syntax check, only if ``pyflakes`` is installed in the active venv.
AKA ``M-x elpy-check``.

``C-c C-d``  shows some (fairly spartan) documentation for the object at the
mark, if available. AKA ``M-x elpy-doc``. 

``C-c C-r f`` Format file per Pep8. Applies only to selected region if there is
one. Otherwise it does the whole buffer. AKA ``M-x elpy-format-code``.

``C-c C-r i``  Clean up imports: reorder, remove unused, query for new. AKA
``M-x elpy-importmagic-fixup``. 

``C-c C-e``  Multiedit symbol names in the whole buffer simultaneously. AKA
``M-x elpy-multiedit-python-symbol-at-point``, which is quite a mouthful. 


Testing
===========

Tests inline inside emacs with color-coded output, woohoo!

NB: The current venv must have ``pyvenv`` in it for this to work. So add that to
the standard set of desired packages.

``C-c C-t``  Run all tests using the current test runner. AKA ``M-x elpy-test``. 

You will need to run ``M-x elpy-set-test-runner`` and choose ``py.test`` before
doing this. However, setting this test-runner does not appear to be persistent!
It defaults to vanilla ``python unittest``, which searches one directory
higher-up than ``py.test``, meaning it ends up searching for tests in *all* of
my python projects, which is disastrous since there are thousands of them and
that's *never* what I want.

To *persistently* set the test runner, you'll want to set a directory-local
variable, as already discussed above. Use ``M-x add-dir-local-variable`` to add
the ``(elpy-test-runner . elpy-test-pytest-runner)`` as a var-value pairing to
the ``.dir-locals.el`` file at the project root. 


  
Appendix I: Default Directory Paths
===========================================

When you launch a REPL based on a python file, it's not always obvious where the
Python process thinks you are for the purposes of imports. The quickest way
around this is as follows:

.. code-block:: python

     >>> import os
     >>> os.getcwd()
     '/Users/scottfitz/code/py/snf/snf'

From there, ``import`` statements should be obvious, as long as you've got your
required ``__init__.py`` at the top of each source directory.

.. code-block:: python

     >>> import core as c
     >>> c.greet()
     Hello World

     >>> import things
     >>> Location
     NameError: 'Location' is not defined

     >>> things.Location
     <class 'things.Location'>

     >>> foo = things.Location()
     >>> bar
     <things.Location object at 0x10a9622e8>

And so on. Elpy seems pretty good about this!

     
   
Appendix II: Summary of Pip Packages
=========================================

My initial tests were made in the ``py351`` venv, which had the following pip
packages installed by the time I was done with this first round of
documentation:

- jedi
- autopep8
- flake8
- pytest
- importmagic

  
