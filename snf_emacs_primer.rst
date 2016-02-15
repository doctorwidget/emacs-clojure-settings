********************************
emacs quickstart
*********************************

Intro & Sneak Peeks
========================

``C-x``  means "CTRL" (and) "x" simultaneously
``M-x``  means "ESC" (then) "x" sequentially 
         You may be able to use OPTION instead of ESC, depending on settings

``C-x o``    Swaps windows, if more than one window is open. *o as in olive*

``C-g``      Cancel. Gets you out of the middle of many operations.
``C-/``      Undo
``M-x undo`` Undo synonym. 
             *Many commands can be typed out at length after M-x.*
             
``C-x C-s``  Save the current buffer
``C-x C-w``  Save As... with the current buffer
``C-x b``    Switch buffers (or create one just by typing a new name)
``C-x k``    Kill a buffer

``C-x C-f``  To open a file.

``C-x C-c``  Quit.

``C-u 4 M-x indent-rigidly``   Indent code blocks by 4, a la Python


Movement
==================

By Character (Arrow Key Style)
---------------------------------

``C-p``  Previous LINE
``C-n``  Next LINE
``C-f``  Forward one CHAR
``C-b``  Backward one CHAR

By Lines & Words
-----------------------------

``M-f``  Forward one WORD
``M-b``  Back one WORD

``M-a``  start of SENTENCE
``M-e``  end of SENTENCE

``C-a``  start of LINE
``C-e``  end of LINE


By Screens
----------------------

``C-v``  forward one SCREEN
``M-v``  backwards one SCREEN

``M-<``  start of DOCUMENT (that's ``shift-option-,``)
``M->``  end of DOCUMENT (again, ``shift-option-.``)

``M-g g``  go to line number (prompt for line# will appear)

``C-l`` ("l" as in lambda) -- redraw SCREEN, centering on cursor


Miscellaneous Essentials
--------------------------------

``C-M-SPACE``  select an entire SEXP (paredit mode only?)

``M-^``        (delete-indentation)  removes everything back to next
               non-whitespace character. NB: OPTION-SHIFT-6.

``DEL``    Plain old delete one (1) character backwards.
``M-DEL``  Delete one (1) **word** backwards.

``C-d``    Delete one (1) character *forwards*
``M-d``    Delete one (1) **word** *forwards*
               

Search and Replace
========================

``C-s``   begin incremental forward search (plain text)
``C-r``   begin incremental backwards search (plain text)

``C-M-s``  begin incremental forward search (regexp)
``C-M-r``  begin incremental backward search (regexp)

``M-% STRING``    Enter query-replace mode
                  The first string is the original.
                  Next, you will prompted for the replacement string.
                  Each match must be *confirmed* or *rejected*
                  ``SPC``  confirms the replacement
                  ``DEL``  skips that instance
                  ``RET``  exit query-replace mode
                  ``.`` replace this one, then exit
                  ``!`` replace all!
                  ``^`` go back one (in case of mistakes)

``C-M-% STRING``   query-replace mode, but with regexps



Copy and Paste
======================

Emacs users don't say *Copy* and *Paste*. They say *Kill* and *Yank*.  You are 
like a Necromancer: you **kill** selections to and then you *yank* them back 
from the grave. The grave can hold lots of bodies at once and Emacs users
refer to it as the ``kill ring``. It's all really very grim. 

``C-SPC or C-@``  begins a mark. 
``MOTION KEYS``   Any motion keys now create a selection from the mark. 

``C-g``  cancels out of the mark... because it cancels out of **everything**

Once a region is selected, the cut (kill) / copy / paste (yank) commands are:

``C-w``    Cut (Kill)      *I like to think of it as "-W-iping"*
``M-w``    Copy
``C-y``    Paste 
``M-y``    Cycle through the paste stack. Must follow a C-y!

``<DEL>``   regular delete: does **not**  go to kill ring!
``C-d``     forward delete: does **not**  go to kill ring!

``M-<DEL>`` delete prior word: **does** go to kill ring
``M-d``     delete next word: **does** go to kill ring 

``C-k``    Kill (cut!) everything to the end of the line. 
``M-k``    Kill (cut!) everything to the end of the sentence. 
           *These commands affect one line, not the whole selection*
           *In both cases, the killed text does go to the kill ring*


All-Purpose Repetitions: 
=============================

``C-u (any number) (any command)`` -> repeats that command X times

*e.g.*
``C-u 8 C-f``   Moves you 8 spaces forward at once
``C-u 9 *``     Plops 9 asterisks in a row at the cursor

``C-u 6 C-v``   Scroll 6 *lines*  (Inconsistent with: ``C-v`` above!)


Interrupts and escapes
===========================

``C-g``  Stops a running command / aborts from a partially typed command
``C-x u``  Undo
``C-/``    Undo


Split screens
======================

``C-x 0``   Absorbs the current window into its parent. 

``C-x 1``   Deletes **all** windows other than the current one. 

``C-x 2``   Splits current screen in two horizontally

``C-x 3``   SPlits current window in two vertically

``C-x o``   (o as in Other window) ... cycles through all available windows

``C+M-v``   (CTRL & Option and v all at once) scroll the Other window down
``C+M+SHIFT-v`` (CTRL & Option & Shift and v) scroll the Other window up
             *These both only work when there are precisely two (2) windows.*

``C-x +``  Makes all windows equal. Invoke after two calls to ``C-x 3`` and you 
           end up with three equally-sized columns. Sweet! 
           

Miscellaneous Text Editing
================================

``C-x C-+`` larger font size
``C-x C--`` smaller font size

``M-;``     comments out the current selected region. You have to select first!

``C-x f 79`` Sets the column width to 79
                  This works for newlines only -- it doesn't backtrack 
         
``M-q``    Lay out the current paragraph using the current column width.  Works on
           paragraphs, not single lines or selections. Emacs will decide for you what
           a paragraph is, and you will like it.

``C-u spc`` Gives you 4 spaces, Python style. ``C-u #`` is the general repeat
            command, but if you omit the number, you get 4 of whatever you provide.

``M-x column-number-mode``  Toggles column counting in the lower info stripe
``M-x line-number-mode``    Toggles line counting in the lower info stripe
``M-x linum-mode``          Toggles line numbers running down side of window
``M-x global-rainbow-delimiters-mode``  (colorful (matching (parentheses)))


Files:
=================

``C-x C-f``  Open a file (then hit return to navigate in dired mode)

``C-x C-s``  Save a file Note that the bottom menu bar will show -UU-:** at the
             start if the file is dirty, and it changes to -UU-: when the file is
             clean.

``C-x s``    Rotates through all dirty buffers, asking if you want to save each

``C-x C-w``  Save as... (new file name!)

``C-x d`` <return> puts you in DIRED mode (aka directory editor). This allows you to
      manually traipse around in directories using arrow keys and the
      corresponding emacs motion keys (C-p, C-n C-b, C-f). Hit return after the
      minibuffer shows you a path, and that's where you'll be. When in this
      mode, regular keystrokes are remapped to special dired commands. Note that
      the dired view is not dynamically updated when you make changes: it takes
      a snapshot of your directory and continues to show it to you even if you
      add or delete files in another program or window.

``('g')`` ``(revert-buffer)``
      A plain old 'g' inside the dired window will reload the
      contents of that directory into dired, showing you the true current
      contents. You can also use M-x (the standard way to get a minibuffer to
      type LISP commands into) followed by 'revert-buffer'.

``('+')`` ```(dired-create-directory)``
     A plain old '+' or M-x + the lisp command will create a new directory
     inside a dired buffer.


Buffers:
========================

``C-x C-b`` to list all current buffers. 

``C-x b`` (*not C-x C-b!*) gives a minibuffer to type the name of the buffer to
            switch to. Works much better than C-x C-b for multiple windows,
            loading the file into whichever window you were in when you issued
            the command.

``C-x s``   Save all unsaved buffers, but you must confirm *y/n* each one.
``C-x C-s`` Save the *current* buffer.

``C-x b BUFFNAME``   Create a brand new buffer

``C-x k BUFFNAME``  Kill a particular buffer
``M-x kill-buffer`` alias

``M-x kill-some-buffers`` Offers to kill all buffers, round robin style. 


Processes:
======================

``C-z``  Suspend emacs from the terminal, but don't close buffers, etc
``$ fg``      Restore suspended emacs session
``$ %emacs``  Restore suspended emacs session

``C-x C-c``  Quit out for real.

             

Menu bar:
======================

``F10 or M-x``  brings up the minibuffer for typing commands

``M-x menu-bar-open`` opens a special menu screen 
                      seems awkward... is this more trouble than it's worth?


Emacs Terms of Art
======================

``point``     The current cursor position

``mark``        A saved spot in the document, and/or the start of a selection. 

``mark ring``   The stack of all previous marks, analagous to the clipboard stack,
                or to the stack of saved undo actions. 

``ring``   A LIFO stack. Pastes, undos, marks, and other things all exist as rings.

``kill``   Cut to clipboard
``yank``   Retrieve from clipboard and paste at the point 



Modes:
======================

Different modes will alter some of the key commands
"Fundamental" mode is the default.

``M-x fundamental-mode``     switches to Fundamental mode
``M-x text-mode``   		switches to Text mode
``M-x python-mode``          switches to Python mode (!)


Shell/Terminal Modes
---------------------------------

``M-x shell`` *or* ``M-x term``
            Change the current buffer into a shell or a full-fledged terminal. 

            Shell keeps you in a true emacs buffer, so you can always move
            around and copy and paste using standard emacs commands. 
            
            Terminal mode gives you color coding (yay!) and is a truer
            representation of an independent window. BUT it adds the complexity
            of two *modes* -- *char mode* and *line mode*. Char mode is more
            like an emacs buffer -- hence, more like ``shell`` -- in terms of
            navigating around the screen and issuing commands to the minibuffer,
            etcetera. In contrast, *line mode* is more like a genuine terminal.
            That means many common emacs buffer commands are disabled. But *line
            mode* is more likely to work with programs that take over the whole
            screen -- e.g. nano -- than *char mode* is. So sometimes you want
            one and sometimes the other.

``C-c C-k`` Toggle to char mode of ``term``. Similar to a genuine terminal. 
``C-c C-j`` Toggle to line mode of ``term``. Similar to an emacs shell. 
 
 ``C-c``    the general replacement for ``C-x`` whene in terminal *line mode*.
            Whatever you would trigger with ``C-x`` outside of a terminal
            buffer, you should be able to trigger via ``C-c`` inside it. So
            ``C-c b`` should let you change away from the terminal buffer, ``C-c
            o`` should transfer you out of the term buffer into whatever the
            next window is in the window cycle, etcetera.
            
``M-x quit``    Closes a shell or terminal session, leaving the window intact.

``M-x rename-buffer`` Rename a buffer. The next time you run ``M-x term`` you'll
                      create a second, separate terminal with the default name.
                      So you can have ``aterm``, ``bterm``, ``cterm``, etcetera.


Finally, note that emacs will look for a file named ``~/.emacs.d/init_bash.sh``
to use as your startup file for both ``shell`` and ``term``. If you have a more
old-school setup that uses an ``~/.emacs`` file in lieu of the ``~/.emacs.d``
directory, you would add a second, separate ``~/.emacs_bash`` file. In either
case, inside that file you would just load your usual bash profile, so it can
contain a one-liner: ``. ~/.bash_profile``.


Clojure CIDER Mode
---------------------------------

These should all be done with two windows: a window with clojure code, and 
then a window with the REPL. I haven't experimented to see what kind of 
weird and wonderful errors you might get otherwise. 

``M-x cider-jack-in``  Start a CIDER REPL in the second window.
                       Type this while inside a Clojure **code** window. 

``C-c C-e``  In the **code** window, evaluates the nearest expression.
             Alias for ``M-x cider-eval-last-expression``
             Evaluates it to the minibuffer output area, not the REPL!
             Also works via ``C-x C-e``, but why not keep the ``C-c`` theme?

``C-c C-k``  Compile everything in the current **code** window, and refresh
             the **REPL** window with those definitions. 


``C-c M-n``  Sets the namespace of the **REPL** window to the top-level namespace
             of the **code** window. NB: only works after at least one
             compilation (C-c C-k) has been run.

             
``C-UP``     Cycle up through the REPL history, terminal-style
``C-DOWN``   Cycle down through the REPL history, terminal-style.

              Errors appear in a special new buffer called *nrepl-error*. 
``q``         Kills the active buffer -- i.e. the *nrepl-error* buffer!

On OSX, all four ``C-ARROW`` keystrokes are bound to Mission Control stuff
by default. Go to *System Preferences>Keyboard>Mission Control* and unbind 
all of the ``^-ARROW`` shorcuts defined therein. 

Update Round 2
....................

in June 2015 I tried my first round of updating both Emacs and my various
packages. It went mostly OK, but there were some quirks with CIDER mode.
Specifically, CIDER mode turns out to depend on TWO package families in entirely
different ecosystems! First, you need your ``*.el`` package installed in Emacs.
Second, Cider invokes ``leiningen``, and leiningen must have access to an
appropriate version of the ``[cider/cider-nrepl]`` namespace. So you have to
manage *one* set of files inside Emacs itself (the ``*el`` family of files), and
*another* set -- this time standard Clojure packages -- inside ``lein``.

To manage the ``lein`` side of things in a global, cross-project way, you need
to provide a custom ``~/.lein/profiles.clj`` file. In it you need to specify
specific versions for both the ``cider-nrepl`` and ``tools.nrepl`` packages. It
was tricky to pin this down, so it's worth keeping in mind going forward.

Specifically, this is the complete contents of my file at
``/.lein/profiles.clj`` as of June 4, 2015:

.. code-block:: clojure

   {:user 
     {:plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]] 
      :dependencies [[org.clojure/tools.nrepl "0.2.10"]]
     }
   }

Note #2
.....................

I did a second round of updates in Feb 2016. This is a multi-step process!

First, inside emacs, I ran ``M-x package-list-packages``, and then manually
chose the ``cider`` and ``clojure-mode`` packages for updating. In both cases
when I had 2 windows open, clicking on the name in the main list popped up an
ASCII UI in the second window. From there I clicked on the *Install* "button".
NB: you must always upgrade *both* of these packages at the same time!

Second, per the most-recent CIDER documentation, I updated the aforementioned
``~/.lein/profiles.clj`` file, moving the ``cider-nrepl`` plugin and the
``tools.nrepl`` dependency out of the *:user* profile and into the **:repl**
profile. 

.. code-block:: clojure

     {:repl {:plugins [[cider/cider-nrepl "0.10.2"]]
             :dependencies [[org.clojure/tools.nrepl "0.2.12"]]}
      :user {:plugins [[com.jakemccrary/lein-test-refresh "0.12.0"]
                      [lein-ancient "0.6.8"]
                      [mvxcvi/whidbey "1.3.0"]]}}

Note that I still have a ``:user`` map, which coexists happily with the
``:repl`` map. 


Paredit.el Mode
----------------------

*Paredit* mode is a special parentheses-happy mode. It is *extremely* handsy
with your code, and is reluctant to accept that no means no. 

``M-DEL`` to override Paredit and backwards-delete whether it likes it or not

``M-SHIFT-9`` aka ``M-(``  Adds parentheses around the current element
                           Alias for ``M-x paredit-wrap-round``,
 
``C-M-space``   Selects an entire SEXP all at once... handy in lisp files
 
``M-;``         Comments out an entire marked area; useful with the above!


Use standard editor *marking* (as for cut-copy-paste) followed by one of 
the following commands to wrap the entire selection:

``M-x paredit-wrap-round``   Wraps with smooth (list) braces
``M-x paredit-wrap-square``  Wraps with square (vector) braces
``M-x paredit-wrap-curly``   Wraps with curly (map) braces
``M-x paredit-wrap-angled``  Wraps with angled (html) braces

``M-s``  to splice an inner form out into its parent outer form
         Think of this as *promoting* the inner contents to the outer tier. 
         This is a *highly* useful command.

``S-RIGHT`` Current list grows by *slurping* one element from the right
``S-LEFT``  Current list shrinks by *spitting* one element from the right

NB: on 2015_12_09 the slurp and spit command bindings above were suddenly
nonfunctional. I could *swear* that they had previously been bound to
``C-RIGHT`` and ``C-LEFT`` automagically, but that was no longer true. I had to
edit my ``user.el`` and manually set the ``S``-based bindings above. Also note
that the equivalent long forms are ``paredit-forward-slurp-sexp`` and
``paredit-forward-barf-sexp``, and that there are a variety of other
``paredit-foo`` commands available via ``M-X``. 

When you're trying to eliminate a list altogther, you should repeatedly
*spit* (``S-LEFT``) until it's empty, and then delete the empty list. 

``C-M-f``  move forward one sexp (of same size as current sexp!)
``C-M-b``  move backward one sexp (ditto)
``C-M-u``  move out/up one tier in the sexp hierarchy

