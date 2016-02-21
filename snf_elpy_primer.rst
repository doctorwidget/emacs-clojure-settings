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

Running
============

Turn it on with ``M-x elpy-enable``, the equivalent of ``M-x cider-jack-in``.

It remembers settings persistently when you set them with ``M-x elpy-config``. 

From ``elpy-config`` you can set a default virtualenv, but really you're likely
to want this to be different from invocation to invocation. You can use the ``M-x
pyvenv-workon`` command to launch virtualenvs for use inside emacs / with elpy,
**but** note that each venv must have the various ``elpy`` helper packages
available for things to work (e.g. ``jedi``, ``flake8``, ``autopep8``, and
``pytest`` at a minimum). 


Missing Packages
======================

Several packages are *not* installed by default, and you'll want them available
when working with elpy. They are all installed via ``pip``, and I assume they
must be available inside the virtualenv set as the default.

In any case, here are some of the the packages that elpy can use if they're available:

- jedi      for autocompletion
- autopep8  for linting
- flake8    for syntax checking
- pytest    as a testrunner
  
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


Interactive Mode
=====================

This, more so than autocompletion or refactoring, is what I'm really after. The
commands are nicely similar to the ones in CIDER: I assume that both draw from
some earlier, well-known mode.

``C-c C-z``  switch to Python REPL buffer, starting one if necessary

``C-c C-c`` sends a full source buffer to the REPL, as in CIDER ``C-c C-k``

``C-c RET`` sends only one statement to the REPL. Seems limited to one-liners.

``C-M-x``   sends a complete class or function to the REPL. 


Syntax Stuff
=================

``C-c C-v``  Syntax check. *Confirmed* ``pyflakes`` must exist in the
currently-active venv or this to work. When it is, this is nice!

``C-c C-d``  shows some (fairly spartan) documentation for the object at the
mark, if available. So, mainly for core Python library functions.


Testing
===========

Tests inline inside emacs with color-coded output, woohoo!

NB: The current venv must have ``pyvenv`` in it for this to work. So add that to
the standard set of desired packages.

``C-c C-t``  Run all tests using ``python -m unittest discover``

You might need to run ``M-x elpy-set-test-runner`` once before this works.
Choosing ``py.test`` made it work right away.

However, at first glance, it seems like the current working directory for which
tests get chosen is highly random. Half the time the testrunner starts searching
my entire ``code/py/`` directory, meaning thousands of tests, which is
*completely ridiculous*. I haven't figured out what's causing this yet, so I've
been just opening a buffer with an ``M-x shell`` and running ``py.test`` from
the precise directory of my choosing. That takes care of all of the pathing
issues and gives me access to the full power of ``py.test`` and all of its
various launch parameters and options.
  
Default Directories
========================

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

     
   
Summary of Pip Packages
===========================

My initial tests were made in the ``py351`` venv, which had the following pip
packages installed by the time I was done with this first round of
documentation:

- jedi
- autopep8
- flake8
- pytest

