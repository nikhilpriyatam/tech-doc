Apache server + python for building an application
==================================================

This section details information about the usage of Apache server + python for
building an application.

CGI - Common Gateway Interface
------------------------------

* Normally, when you click a URL, your browser (which is a HTTP client) contacts
  HTTP web server and demands for the URL i.e. filename. Web server parses the
  URL and looks for the filename. If it finds the file then it sends to the
  browser else returns error.

* It is possible to setup the HTTP server so that whenever a file in a certain
  directory is requested, it is not returned - instead it is executed as a
  program and the programs output is returned to the browser to display. This
  function is called Common Gateway Interface (CGI) and the programs are called
  CGI scripts which can be a python, perl, shell, C or C++ program.
