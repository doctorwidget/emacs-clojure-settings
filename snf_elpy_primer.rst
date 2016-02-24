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

Your emacs startup script (e.g. ``.emacs.d/init.el``) should call
``(elpy-enable)`` somewhere just once. This sets things up to automatically
recognize python files and enter ``Elpy Fill`` minor mode, which co-exists with
Python mode.  This is *not* something you should be calling manually on a
per-session basis! It's really part of the installation process, and should be a
persistent addition to your emacs startup script.


Configuration
==================

You can persistently change settings with ``M-x elpy-config``, but this can be
somewhat misleading, because some settings *only* make sense when set via a
``.dir-locals.el`` file, whereas others are things you'll just want to set once
globally. For example, the virtualenv to use, the testrunner, and the project
directory should all really be set on a *per-project* basis via a
``.dir-locals.el`` file in the top directory of the project. Other settings
(e.g. stuff like code formatting and code checking settings) should be set
globally from here.

One of the few things you will want to make sure is *globally* set from here is
the ``pyvenv-mode`` setting in in the ``Python`` group. This should be toggled
**on**, which means ``elpy-mode`` will look for a virtualenv to load whenever a
python file is opened. However, you don't want a *global* default virtualenv; as
discussed above, you want a ``.dir-locals.el`` file. So ``pyvenv-mode`` =
globally on, but the specific virtualenv = set locally. You *can* use the ``M-x
pyvenv-workon`` command to *manually* change virtualenvs, but this will rarely
be useful.


dir-locals.el
------------------

As noted above, several variables really should be *persistently* set on a
*per-project* basis. There are commands to set them globally, but there's no
upside to doing that.

- ``elpy-project-root``, containing an absolute path from ``~`` to the project
  root. This will be used as the basis for finding tests, doing global searches
  within the project, and so on. 
- ``elpy-project-ignored-directories``, containing directories not to search in
  or run tests from. 
- ``elpy-test-runner``, which will almost always be ``elpy-test-pytest-runner``,
  but still makes sense to have as a per-project variable. 
- ``pyvenv-workon``, containing a valid name for the virtualenv ``workon``
  command. 

The way to do this is to take advantage of a core emacs feature:
*directory-local variables*. Emacs looks for a file named ``.dir-locals.el`` any
time it opens a file anywhere. If it finds it, it applies any variable
declarations within to the environment before it starts editing that file.
Crucially, emacs also looks *up* the hierarchy for any ``.dir-locals.el`` files
*above* the current file. That means any ``dir-local.el`` file applies to all
files in all child directories too, which is exactly what we're after.

Rather than manually editing your ``.dir-locals.el`` file, you can use the
command ``M-x add-dir-local-variable`` while editing a top-level file. This
gives you a nice little auto-popup buffer with the formatted contents of the new
``.dir-locals.el`` file. Subsequent calls gracefully add new entries to that
list. You should create precisely one (1) such file per project, at the project
top and defining the symbol ``elpy-project-root``.

Of course, after creating the first one with ``add-dir-local-variable``, future
projects might be better served by just copy-pasting an existing
``.dir-locals.el`` and filling in the appropriate new values. Here's an example
``.dir-locals.el`` file after using the command to add two dir-local variables
for the ``snf`` project:

.. code-block:: lisp

    ;;; Directory Local Variables
    ;;; For more information see (info "(emacs) Directory Variables")

    ((python-mode
      (elpy-test-runner . elpy-test-pytest-runner)
      (pvenv-workon . snf)
      (elpy-project-root . ~/code/py/snf/snf)))

Now whenever you open *any* file in that directory *or all child directories*,
``elpy`` will have access to those variables. So the correct virtualenv will be
*automatically* used, the correct test runner will be *automatically* used,
project-wide searches will have the correct apex, and so on. 


Inspecting Per-Buffer Variable
......................................

``C-h v`` shows the value of any variable. AKA ``M-x describe-variable``. You
can use this to confirm the current value of per-buffer variables such as
``elpy-project-root``, ``elpy-test-runner``, etc.


Pip Packages
---------------------------------

Note that each virtualenv must have the various ``elpy`` helper packages available for
things to work:

- jedi        for autocompletion
- autopep8    for linting
- flake8      for syntax checking
- pytest      as a testrunner
- importmagic for messing with imports 
- rope        for refactoring
  
The smart thing to do here would be to make a standard ``dev.txt`` file in
``pip`` requirements format. You could then plop into your ``requirements/``
directory for any new project. They wouldn't be part of the ``base.txt`` files,
because they're specific to you as a developer, and are unnecessary for the
deployed machine. Of course, that assumes you're using the multiple requirements
file pattern, but why wouldn't you be?

.. code-block:: bash

   # example of requirements/dev.txt pip file
   autopep8
   flake8
   importmagic
   jedi
   pytest
   yapf

There's no need to pin version numbers in this file.


Interactive Mode
=====================

``C-c C-z`` switch to Python REPL buffer, starting one if necessary. Toggles
between REPL and source after the first invocation starts the REPL. This does
*not* load any of the code from the current window! You'll need to either follow
up with a ``C-c C-c``, or start running ``import`` statements in the REPL. AKA
``M-x elpy-shell-switch-to-shell``.

``C-c C-c`` sends a full source buffer to the REPL, or a complete selected
region if you have one active. AKA ``M-x elpy-shell-send-region-or-buffer``

``C-c RET`` sends one (1) statement to the REPL. AKA ``M-x
elpy-shell-send-current-statement``. 

``C-M-x``   sends nearest/outermost class or function definition to the REPL.
AKA ``M-x python-shell-send-defun``. 

``M-x elpy-rpc-restart``  Restarts the REPL Python process, in case things have
gotten wacky on you. 


Project Features
====================

You'll need a project defined in your ``.dir-locals.el`` for this to work. 

``C-c C-f``  Finds a file within the project. AKA ``M-x elpy-find-file``.

``C-c C-s``  Grep search within the project. AKA ``M-x elpy-rgrep-symbol``. 


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

``C-c C-t`` Run all tests using the current test runner. AKA ``M-x elpy-test``.
Sometimes it seems like I have to run the command once via ``M-x elpy-test``
once before ``C-c C-t`` works.


Appendix I: Path Fu
===========================================

When you launch a REPL based on a python file, it's not always obvious where the
Python process is using as the current working directory. Use the ``os`` module
to clarify things:

.. code-block:: python

     # launched an elpy repl while in ~/code/py/snf/snf/core.py
     >>> import os
     >>> os.getcwd()
     '/Users/scottfitz/code/py/snf/snf'

So even though we've got our fancy-schmancy ``.dir-locals.el`` defining a
*project* root of ``/Users/scottfitz/code/py/snf``, the launched REPL is one
level lower down than that, in the same directory as the file we had open when
we hit ``C-c C-z``. That will play havoc with import statements! One possible
workaround is to use the ``os`` package to change the current directory:

.. code-block:: python

    >>> import os

    >>> os.getcwd()
    '/Users/scottfitz/code/py/gedomatic/gedutils'

    >>> os.chdir('..')
    >>> os.getcwd()
    '/Users/scottfitz/code/py/gedomatic

    >>> import gedutils.gedomatic.Gedfile as G
    Traceback blah blah
    ImportError blah blah 'gedutils.gedomatic' is not a package. 
    # That didn't work because it's not how you access things *inside* a module

    >>> from gedutils.gedomatic import Gedfile as G
    # this *is* how you access things inside a module, and it works

    >>> G
    <class 'gedutils.gedomatic.Gedfile'>
    
    >>> import gedutils.gedomatic
    # unadorned import statements work iff targeting a complete *modules*

    >>> gedutils.gedomatic
    <module 'gedutils.gedomatic' from '/Users/scottfitz/code/py/gedomatic/gedutils/gedomatic.py'>
    
    >>> gedutils.gedomatic.Gedfile
    <class 'gedutils.gedomatic.Gedfile'>

    >>> G == gedutils.gedomatic.Gedfile
    True
    
A second option would be to use the ``sys`` package to append whatever you
consider the top level to the search path.

.. code-block:: python

    >>> import sys
    >>> sys.path.append('..')

And from there, all of the examples above work. 

    

    



  
