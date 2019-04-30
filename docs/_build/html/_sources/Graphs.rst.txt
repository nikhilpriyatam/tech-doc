Graphs
======

There is a nice `graph tool library<https://graph-tool.skewed.de/>`_ in python which allows you to do various kinds of computations on graphs. It is written in C++ (For efficiency), but the
wrapper is available in python. 


Installation on Ubuntu
----------------------

* sudo apt-get install python3-cairo python3-dev libcairomm-1.0-dev libgitrepository-1.0-dev
* pip install pycairo
* ln -s /usr/lib/python3/dist-packages/gi/ <PATH_TO_MINICONDA_PYTHON>/lib/python3.5/site-packages/gi
* More instructions are given here: https://git.skewed.de/count0/graph-tool/wikis/installation-instructions

  Add folloing lines to `/etc/apt/sources.list` where DISTRIBUTION can be any of xenial, yakkety, zesty, artful, bionic, cosmic.
    deb http://downloads.skewed.de/apt/DISTRIBUTION DISTRIBUTION universe
    deb-src http://downloads.skewed.de/apt/DISTRIBUTION DISTRIBUTION universe

    sudo apt-get update
    apt-key adv --keyserver pgp.skewed.de --recv-key 612DEFB798507F25
    apt-get install python3-graph-tool

* ln -s /usr/lib/python3/dist-packages/graph_tool/ <PATH_TO_MINICONDA_PYTHON>/lib/python3.5/site-packages/graph_tool
