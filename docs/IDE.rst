Various kinds of IDE
====================

Vim as IDE
----------

1. Vim can easily be used as a full fledged IDE with code completion, code highlighting, linting and many more.

2. This :download:`Vimrc file <./config_files/sample_vimrc>` contains all the instructions for compiling Vim from source, installing external plugins, etc.

3. You can comment out a block of code in python using vim in the following way:

   * :code:`Esc` to leave editing mode
   * :code:`ctrl + v` to go to :code:`visual mode`.
   * Select the lines that you want to comment (using up/down keys)
   * :code:`Shift + I` which will put editor in insert mode.
   * Insert the text that you want (in this case :code:`#`)
   * press :code:`Esc`

4. You can also **uncomment** out a a block of code

   * :code:`Ctrl + v` to go to `visual mode`
   * Put the cursor on the first :code:`#` and go down until the last comment line and press `x`
   * This will delete all :code:`#` vertically.

5. You can **indent** as well as **unindent** your python code using the following

   * When indenting or unindenting, lines are shifted one :code:`shiftwidth` to the right or left.
   * In `normal mode` press :code:`5>>` to shift 5 lines to right and :code:`5<<` to shift 5 lines to left.    
   * :code:`Shift + v` to goto `visual mode` which operates at line levels
   * Select the lines using cursor and use :code:`>` to shift right or :code:`<` to shift left.

6. Setting up Vim for Mac

   * Use only MacVim not normal Vim. Clone from `MacVim <https://github.com/macvim-dev/macvim>`_ repository.
   * As of now try to compile Mac with either Python 3 or Python 2, not both.
   * I configured vim to use p3.5 (python 3.5) anaconda environment.
   * Exact instructions for building Macvim is given `here <https://github.com/b4winckler/macvim/wiki/Building>`__
   * Set environment variable :code:`CC='clang'` in .bashrc
   * Set :code:`export VIMRUNTIME="/Users/nikhilpattisapu/Tools/macvim/runtime/"` in .bashrc


Atom
----

1. To install a package in Atom use :code:`apm install packageName`

2. To install behind proxy::

    apm config set https-proxy http://proxy.iiit.ac.in:8080` (The URL **should** start from http **not** https)
    apm config set http-proxy http://proxy.iiit.ac.in:8080`
    apm config set proxy http://proxy.iiit.ac.in:8080`.

3. To modify the settings of a particular package `Atom -> Preferences -> Packages -> Specific Package -> Settings`

4. To enter the command-line mode

   * On Mac: `Shift + Command + P`
   * On Ubuntu
  
5. To define a python cell use the comment in the following way `# %%`

6. I had some problems with the default `markdown-preview` package.

   * I fixed it by going to `preferences -> settings -> packages -> markdown-preview -> disable` then `enable` again.
   * Somehow, there were also some bugs w.r.t the window panes. You can modify the options in a similar way as mentioned above.

7. I faced an issue with `atom` where, the python code for calling a `StanfordCoreNLP` server was working in terminal and **not working in atom**. My guess is that, this is due to proxy issues. I could not confirm it though. The following is the code snippet::

    from pycorenlp import StanfordCoreNLP
    nlp = StanfordCoreNLP('http://10.4.17.63:9000') # The server http://10.4.17.63:9000 is accessible through browser.
    text = ('He went to a dentist.')
    op = nlp.annotate(text, properties={'annotators': 'tokenize,ssplit,pos,depparse,parse','outputFormat': 'json'})


Micro - terminal based editor
-----------------------------

1. Help available `here <https://github.com/zyedidia/micro>`_
   
2. Installation on Mac - `brew install micro`
   
3. Installation on ubuntu - The instructions given in the `here <https://github.com/zyedidia/micro>`__ were **NOT** helpful for me. So, I used the following procedure
   
   * Download the required package from https://github.com/zyedidia/micro/releases
   * `tar -xvf micro-1.2.1-60-linux64.tar.gz`
   * copy the binary `micro` file inside the `micro-1.x.x` directory to `/bin/`
   * Execute `micro` command from terminal in a normal fashion.

