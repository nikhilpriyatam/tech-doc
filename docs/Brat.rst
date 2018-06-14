BRAT Annotation Framework
=========================

* For ubuntu, Install Apache2 on Ubuntu normally
* Make a new `VirtualHost` entry in the following file
  :code:`/etc/apache2/sites-available/000-default.conf`. While everything
  remains the same as mentioned in apache2 configuration the **except the
  following**::

    DocumentRoot /home/i1392424/Tools/brat-v1.3_Crunchy_Frog
    <Directory /home/i1392424/Tools/brat-v1.3_Crunchy_Frog>
    AllowOverride Options Indexes FileInfo Limit
    AddType application/xhtml+xml .xhtml
    AddType font/ttf .ttf
    Require all granted

    # For CGI support
    Options +ExecCGI
    AddHandler cgi-script .cgi

    # Comment out the line above and uncomment the line below for FastCGI
    # AddHandler fastcgi-script fcgi
    </Directory>


* Activate CGI or FastCGI- :code:`a2enmod cgi` or :code:`a2enmod fcgi`
* Follow BRAT configuration instructions as present `here
  <http://brat.nlplab.org/configuration.html>`_

* There are 4 main configuration files

  * :code:`annotation.conf` [Contains configurations about **Entities,
    Relations., Events and Attributes**]

  * :code:`visual.conf` [Contains configurations about visual appearance - not important]
  * :code:`tools.conf` [Did not explore yet]
  * :code:`kb_shortcuts.conf` [Contains configurations about keyboard shortcuts - not important]

* Create the above files in the :code:`data` directory in :code:`brat` folder.
  Copy all other folders that are to be annotated in this `data` directory.

* Make sure the above data directory is readable and writable :code: `sudo
  chmod -R data`.
* For each :code:`.txt` file there should be a corresponding :code:`.ann`
  file.
* In the :code:`config.py` file in main `brat` folder, please add all
  :code:`username:password` pairs
* **TODO** : Figure out how to do automatic redirection of a logged-in user to
  his/her corresponding user directory.
