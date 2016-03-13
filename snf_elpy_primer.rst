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


Venv Inconsistencies
..............................

Note that any given project will use one of ``pyvenv-workon`` or
``pyvenv-activate``, but never both. Both commands result in an activated
virtualenv, but the former targets only valid ``workon`` targets, while the
latter targets any virtualenv anywhere. The former works through
``virtualenvwrapper`` (which shouldn't be surprising, since that's where the
``workon`` command originates), while the latter works through the
more-primitive/more-foundational ``virtualenv``.

Why not just do everything through ``pyvenv-workon``, since ``workon`` and
``virtualenvwrapper`` are generally more convenient than vanilla ``virtualenv``?
The answer is that for some small one-off projects I sometimes want to create
venvs directly in the project directory, to be accessed via ``virtualenv``
rather than ``workon``. If I'm creating a minor, possibly short-lived venv, such
as one I might create when working through book examples, there's no need to
enshrine it in my main ``workon`` menu. And yet I don't want to create and then
delete a ``workon`` target, because I might come back to the book examples again
later.

So most of the time projects will use venvs accessible via ``pyvenv-workon``, but
sometimes I want to take advantage of ``pyvenv-activate``. The trick part is
that ``pyvenv-workon`` and ``pyvenv-activate`` require different variable
definitions in your ``.dir-locals.el`` file. ``pyvenv-workon`` takes an unquoted
*symbol* argument, as shown above. But ``pyvenv-activate`` takes a *string*
argument, which must be a full path to the venv directory, *omitting* the
``bin/activate`` fragment. There's no intuitively obvious reason why either of
those things would be true, so I wasted some time figuring this out.

So where the example above has a succinct ``(pyvenv-workon . snf)`` expression
inside ``.dir-locals.el``, the expression for ``python-activate`` is longer and
less obvious:

.. code-block:: lisp

      ; other values and boilerplate omitted
      (pyvenv-activate . "~/code/py/book/lightweight/lightvenv")
      
Not only did I get tripped up over the (undocumented) string-versus-symbol
issue, it took some experimenting to figure out that the argument ends with
plain old ``lightvenv`` rather than ``lightvenv/bin/activate``. Now you know!

NB: As a final weirdness, note that emacs stores a list of "save local
variables", confirmed by the user to be OK to use, inside ``init.el``. My quoted
string above is saved to the ``init.el`` safe-local-variable-values list as
follows:

.. code-block:: lisp

     ; most of safe-local-variable-values not shown
     (pyvenv-activate quote /Users/scottfitz/code/py/book/lightweight/lightvenv)

Showing yet *another* variation on how this can be stored.


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




Elpy Path Fu
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


Reloading Modules
---------------------------------

Working with a REPL side-by-side with Python source files is great, but it can
be tricky to get changes from the file into the REPL. Sometimes you can use one
of the commands below like ``C-c C-c`` or ``C-M-x``, but sometimes you just want
to reload the complete buffer *as a module*. In Python 2.x there was no way to
do this, but as Python 3, the ``importlib`` allows you to do exactly this.

.. code-block:: python

   >>> from importlib import reload

   >>> reload('gedutils.gedomatic')

The ``importlib`` module offers a variety of other tools for use by developers
writing specialized libraries... but the ``reload`` function is potentially
useful to anyone who wants to do REPL-based development. 

Searching
==================

Note that ``C-C C-s`` (aka elpy-rgrep-symbol) function mentioned below doesn't
actually work very well in practice: all it ever gives me is an error about
wrong argument types stringp blah blah. You'll get better results with the
built-in emacs functions:

``find-grep`` || ``grep-find``  (synonyms). This lets you type a complete
``grep`` command into the minibuffer. You get a template which includes a *lot*
of options!

.. code-block:: bash

    Run find (like this): find . -type f -exec grep -nH -e  {} +

The ``.`` near the front should be replaced by the search path. The regular
expression should get inserted between the ``-e`` and the ``{}``. The ``-nH``
turns on file names and line numbers in the output, and the ``-e`` precedes the
regular expression. Simple regex literals can be typed out sans quotes, but as
soon as you need anything fancy you should single-quote the whole thing.

NB: the weird trailing ``{}`` and ``+`` have *nothing* to do with the usual
regex modifiers for number of matches; the ``{}`` will be template-expanded with
a file name, and the ``+`` is the terminator for the ``-exec`` clause. So
``-exec`` is a modifier for ``find``, which says "run the following command on
each and every file, templateexpanding the file name into the ``{}``, and ending
at the ``+``.

Adding an ``I`` option (i.e. change ``-nH`` to ``-nHI`` will skip over binary
files. If you don't do that you tend to end up with a lot of binary file
matches.

Add ``i`` option (e.g. ``-nHIi``) for a case-insensitive search.

Finally, rather than typing out the complete search path, you have the option of
opening a ``dired`` window and navigating to where you want the top of the
search to start (generally this will only be one or two levels up). When you run
``grep-find`` from a dired window, the current directory is the ``.`` for that
search. That might not be any faster but it feels less hacky than moving the
cursor all around the minibuffer.

You can also use ``find-grep-dired`` instead of ``find-grep`` and ``grep-find``.
This has the advantage of a clearer and more explicit user experience (you get
prompted in the minibuffer separately for the directory and the regexp), but it
does *not* include line number matches in the results, which makes it *far* less
useful.

Finally, the ``rgrep`` and ``lgrep`` commands seem to offer the best of both
worlds, prompting you for regex, directory to search, and even default file
suffix to search in. They *do* provide line numbers in the output buffer. 


Appendix I: Elpy Commands
======================================

REPL Commands
---------------------------------

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
_________________________________

``C-c C-f``  Finds a file within the project. AKA ``M-x elpy-find-file``. NB:
this works nicely if the project is set correctly. 

``C-c C-s`` Grep search within the project. AKA ``M-x elpy-rgrep-symbol``. NB:
always throws error regarding argument types (stringp, blahblah) as of 2016-Feb.
Use vanilla ``rgrep`` instead; it's slightly more typing but actually works.

``C-c C-t``  Run all tests using the current test runner. AKA ``M-x elpy-test``.
NB: works nicely if project and elpy-test-runner are both set. 

``M-.`` Go to the definition of the current symbol *inside* the current window.
AKA ``elpy-goto-definition``. Consider ``elpy-goto-definition-other-window``
instead, because who wants to overwrite the current buffer? Alternatively use
this with ``M-*``, below, to toggle between original / source and back again. 

``M-*`` Pop back and forth between an ``M-.`` buffer and its origin. AKA
``elpy-pop-tag-mark``. Works pretty well!

Syntax Tools
---------------------------------

``C-c C-v``  Syntax check, only if ``pyflakes`` is installed in the active venv.
AKA ``M-x elpy-check``.

``C-c C-d``  shows some (fairly spartan) documentation for the object at the
mark, if available. AKA ``M-x elpy-doc``. 

``C-c C-r f`` Format file per Pep8. Applies only to selected region if there is
one. Otherwise it does the whole buffer. AKA ``M-x elpy-format-code``.

``C-c C-r i``  Clean up imports: reorder, remove unused, query for new. AKA
``M-x elpy-importmagic-fixup``. NB: nothing but errors as of 2016-Feb

``C-c C-e``  Multiedit symbol names in the whole buffer simultaneously. AKA
``M-x elpy-multiedit-python-symbol-at-point``, which is quite a mouthful. 






    



  
