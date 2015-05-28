******************
Themes
******************

You can add themes *manually* to your ``.emacs.d/themes`` folder, but it's
better to do everything through the relatively-modern ``ELPA`` system. Think of
``ELPA`` as being to Emacs  as ``pip`` is to Python.


A Brief Review Of Lifecycles and Ecosystems
===================================================

When emacs runs, it looks in your ``.emacs.d`` directory for configuration files
and such. The first one it loads will be ``init.el``. 

init.el
--------------

Our ``init.el`` file does three things: 

#. wires up our package repositories for use by ``ELPA``
#. loads ``user.el`` (see below)
#. does some configuration of the ``Custom`` system, which is the
   relatively-modern way to use themes with emacs.

Other than that, we're not currently doing anything here. In theory we could add
to it, but I think it's better to leave ``init.el`` short and sweet, and reserve
most customization for ``user.el``.


user.el
----------------

Again, this appears to be loaded only because ``init.el`` calls for it to be
loaded. You can see that it came preloaded with a bunch of options, some of
which I've disabled. Other things are there because I added them. 

In the ``Themes`` subsection, you can see where I've defined my own custom
directory for local themes that I want to manage manually. Again, I no longer
think this is the best approach, but I've left those lines in there just to show
how it's done. 

git
-------------

I've got my whole ``.emacs.d`` directory defined as a git repository, and I keep
it backed up on github. The whole configuration process is scary, and I sleep
better knowing that I can both reinstall to this machine and/or install to a new
machine without starting all over from scratch.
 
When inside ``.emacs.d``, use any git command and you'll see this is the case. 


Package Repositories
===================================

Note that our version of ``init.el`` promptly wires up ``ELPA`` to use three
different archives: ``marmalade``, ``tromey``, and ``melpa-stable``. You can see
their URLS right there at the top of the configuration file. When you run 

.. code-block:: emacs

   M-x load-packages

you automatically end up searching all three repositories, and you see a
giganormous list of results. The list is, in fact, so giganormous that it's not
too useful for browsing. For the most part, I've had much better luck just
googling for what I want, finding the home page for an appropriate package, and
reading their docs to see the specific package name. If you have that specific
package name, then you can bypass the giganormous list and instead:

.. code-block:: emacs

   M-x package-install name-of-my-spiffy-new-package


Occasionally you should refresh the package list; this may clear up odd ``file
not found`` type messages:

.. code-block:: emacs

   M-x package-refresh-contents



Starter Packages
------------------------

The main thing I started with was a bundle of related packages under the
``starter-kit-*`` rubric. This is the starter kit developed by Phil Hagelberg of
the Clojure community, which is why I used it. It included important tools like
``paredit`` and the ``clojure-mode`` stuff. However, it doesn't look (from the
github page upate in late 2014) like it's going to be maintained going forward.
However, here are some of the packages it included:

- magit (git stuff)
- smex  (adds ``ido`` feedback to M-x commands)
- ido-ubiquitous (more ``ido``; this is minibuffer bar autocompletion stuff)
- paredit  (parentheses handling)
- clojure-mode  (Clojure source file editing)
- cider    (Clojure REPL tools)

Note that Python support seems to be built into the core of Emacs 24 (yay), but
I had to install helpers for both Clojure and Haskell. 

The good news is, thanks to ``ELPA``, it's easy to see *all* of your installed
packages, since they all live in the ``~/.emacs.d/elpa`` directory. From there
you can google away for more information. Installed themes live here too! 


Themes
======================

You can get far more themes than you could possibly want via ``ELPA``. You can
also install them manually, and when I first started using Emacs I did just
that, because I was lost in a sea of configuration options, and it seemed
simpler to manually manage a tiny handful of available themes. And in fact, to
this day, it seems that most themes are *not* available on the main public
repositories. 


ELPA Themes
...................

The best approach is to go all-in with ``ELPA``, which means you start by
finding the name of a theme you like out on the web, in a browser, not inside
emacs! Then you issue these commands inside emacs:

.. code-block:: emacs

   M-x package-install solarized-theme

   M-x load-theme solarized-theme


And of course, you can make that the default by adding the appropriate command
to ``user.el``, like so:

.. code-block:: lisp

   (load-theme 'solarized-theme t)


Manual Themes
..........................

As mentioned above, I have chosen to have all of my manually-managed themes live
in ``~/.emacs.d/themes``, where they will part of the main git repository. To
install a new manually-managed theme, the first thing to do is find it on the
web and download a local copy of it inside ``~/.emacs.d/themes`` as an ``.el``
file.

Then instead of calling ``package-install``, you call ``package-install-file``
and use the minibuffer to find the specific theme file. A few seconds later,
that theme should now be available for ``load-theme``, both in the minibuffer or
via a permanent call inside ``user.el``. This moves a copy of that local file
toyour ``.emacs.d/elpa/`` directory, so you will see at least two changes in
git, not just one.

The very first time you use ``load-theme`` to see the theme in action, emacs
will grill you about whether you really want to do it because it might be
unsafe! Fortunately, you get the option to define it as safe forever after that. 


Things To Turn Off
.....................

You can see inside ``init.el`` that I turned off one of the commands to the
``Custom`` system (the modern theming system). The ``paredit`` system really
fights you if you want to turn off a complete SEXP that spans more than one
line. A single line is easy -- just type ``;``! But for a multiline SEXP, you
must put the cursor at the very first character of the SEXP, and then:

.. code-block:: emacs

   C-M-space   

   M-;

The first command marks an entire SEXP all at once; very handy! The second
comments or uncomments whatever is currently marked. 

When ``(custom-set-faces)`` was *not* commented out, it was overriding key
variables in every single theme, so they *all* had background color ``#000000``
and foreground color ``#eaeaea``, etcetera. No bueno!


List of Themes
.....................

Some of the (mostly-light) themes I've added via ELPA and/or manually:

#. solarized-theme    # light or dark
#. anti-zenburn       # gray
#. oldlace
#. professional-theme
#. light-soap
#. soft-stone
#. soft-morning
#. organic-green
#. grenier

And some of the preinstalled ones that look good include:

#. adwaita      # the only default light theme that looks okay
#. deeper-blue     
#. manoj-dark      
#. tomorrow-night-bright
#. wombat

