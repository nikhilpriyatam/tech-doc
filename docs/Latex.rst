LaTeX
=====

General
-------
* Use :code:`\input{filename.tex}` to include content of another latex file in the main tex file.
* For making PPTs in Latex **Beamer** is very useful. For customization options refer `Beamer appearance cheat sheet <http://www.cpt.univ-mrs.fr/~masson/latex/Beamer-appearance-cheat-sheet.pdf>`_

Images
------

* For creating publication ready images, I recommend the following 2 things
  * Dia (Available on both Ubuntu and OSX). On Mac, the controls are slightly different.

    * Dia has some installation issues on OSX. `This blog <http://navkirats.blogspot.in/2014/10/dia-diagram-mac-osx-yosemite-fix-i-use.html>`_ helps us fix it.
    * :code:`ctrl+x`, :code:`ctrl+c`, :code:`ctrl+v`, :code:`ctrl+s` for cut, copy, paste and save (Don't use :code:`command` button)
    * :code:`ctrl+e` for viewing the entire image on a single page canvas.
    * :code:`fn+delete` to delete an object.
    * :code:`fn+left arrow`, :code:`fn+right arrow` for jumping to beginning or ending of the text.
    * :code:`Space + double click` on canvas to insert an image from system.
    * :code:`fn+shift+click` to select multiple objects.

  * Dia has the capability to export the diagram to :code:`tikz/latex` code. One can use that functionality to further improve the diagram by editing the :code:`tikz` code.

Tables
------
If your table spans more space than the width of a page, you can use the command :code:`scriptsize` to fit it exactly in 1 coloumn.

Spell Correction
----------------
* Use :code:`aspell -t -c file.tex` from terminal to highlight the mis-spelled words in a latex file. 
