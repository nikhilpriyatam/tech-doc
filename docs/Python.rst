======
Python
======

Steps while creating a new python project
=========================================

Whenever you create a new python project, make sure they have the following components.

* :file:`README.rst` - Describes the project name, purpose, installation procedure, relevant publications, acknowledge contributors.
* :file:`LICENSE`

   * It allows others to reuse your code in a hassle free way. `Coose a license. <https://choosealicense.com/>`__
   * MIT License is the most simple and permissive, Other options are GNU GPL v3 or Apache License Version 2.
   * It is a good idea to have a copy of these license files in :file:`~/.vim/` folder and define custom mappings as shown below.
   * It is very convenient to have a VIM mapping such as :code:`map :mit :0r path_to_mit_license_file`

* :file:`setup.py` - Useful for building, packaging and distributing your code.

   * :code:`pip install --upgrade setuptools`
   * Follow setuptools documentation for creating this file.
   * Look at the sample project's `setup.py. <https://github.com/pypa/sampleproject/blob/master/setup.py>`__

* :file:`requirements.txt` - Describes the exact dependencies required by your project.

   * This file can be generated automatically for which there exist multiple methods.
   * First method, use **virtualenv** to create a new virtual environment. Switch to this environment. Do fresh pip installs and :code:`pip freeze > requirements.txt`
   * Second method, use **pipenv** to create a new virtual environment using :code:`pipenv install`, activate it using :code:`pipenv shell` and do regular pip installs pipenv will automatically add the package to the pipenv file that’s called :file:`Pipfile`
   * Third (recommended) method, install **pipreqs** and execute `pipreqs /home/project/location`. It will create a :file:`requirements.txt` in the specified location.

* :file:`your_package_folder/__init__.py` - An empty file which tells python to treat the folder as package.
* :file:`your_package_folder/your_modules.py` - python modules in your package.
* :file:`docs/conf.py` - `docs` represents document folder. The :file:`conf.py` indicates configuration file for Sphinx document builder.
* :file:`docs/index.rst` - The index file which contains the reference for other document files.

   * Create a folder :file:`docs` in the repository root. Execute :code:`sphinx-quickstart`.
   * Follow steps given `here <https://developer.ridgerun.com/wiki/index.php/How_to_generate_sphinx_documentation_for_python_code_running_in_an_embedded_system>`__
   * Edit the :file:`docs/conf.py` so that it contains the following lines (along with other lines).

      .. code-block:: python
         
         import os
         import sys
         sys.path.insert(0, os.path.abspath('..'))
         autodoc_member_order = 'groupwise'
         extensions = ['sphinx.ext.autodoc']
   
   * Add modules to :file:`index.rst`
   * Run the command :code:`sphinx-apidoc -o your_project_docs_folder_path your_project_path`

* :file:`tests/` - This folder contains seperate testing code.

Documentation
=============

* Always follow proper `documentation guidelines <https://realpython.com/documenting-python-code/>`__ .
* Use this `reStructuredText based python documentation example <https://thomas-cokelaer.info/tutorials/sphinx/docstring_python.html>`__
* Always follow `PEP 8 <https://pep8.org/>`__ guidelines while writing python code. It really helps in the long run.
* Although there are several Docstring formats. I prefer reStructuredText. It is short, simple and to the point.
* For generating documentation from your python code, along with the discussion, follow `sphinx for python documentation blog <https://gisellezeno.com/tutorials/sphinx-for-python-documentation.html>`__.



Use Ipython inside a Python Program
===================================

To inspect variables in a python script (which takes long to run), you can insert the following lines in your code to start an ipython kernel.

`from IPython import embed`
`embed() # Place this line somewhere in your program`

Anaconda or Pip
===============
* Always use python provided by Anaconda (Do not use the default python provided
  by ubuntu). The difference between pip and :code:`conda` is given
  `here
  <https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/>`__

* Always try to install packages using conda.

  * In :code:`Anaconda`, you can create multiple environments. The python version and
    package installations in those environments are mutually exclusive.

  * Environment creation - :code:`conda create --name snakes python=3`

    * Environment activation - :code:`source activate snakes`
    * Environment deactivation - :code:`source deactivate snakes`
  
    * I have 3 environments on my Mac.
      * One for default (Python2)
      * One for python3
      * One for Magenta
  
    * To install a specific python version in an environment use :code:`conda install python=2.6`
    * You can also search for various versions of a package using :code:`conda search packageName`
    * You can list the existing conda environments using :code:`conda env list`

* To install packages through pip use :code:`pip install package_name`. To
* To upgrade installed packages :code:`pip install package_name --upgrade`
* Recently, I encountered the issue. Upon upgrading to python 3.6 in miniconda,
  * I was getting the following errors with pip installs - :code:`pip install failing due to ssl module not available.`. I fixed it using the following commands.
  * :code:`source activate snakes` (My python 3.6.2 virtual environment)
  * :code:`conda update openssl`.


Multiprocessing
===============

* Multiprocessing is a highly convenient option for parallel processing in
  python. The following is a sample script that takes a string list as input
  and modifies the strings in a parallel fashion.

* There are scenarios, where data needs to be shared between multiple threads
  (e.g. increment or decrement global variables).
  * If it is a counter, always try to pass counter values as additional inputs rather than sharing them between processes.

   * **Note** - Global variables are not shared between processes. We need special kinds of variables

      .. code-block:: python

         from multiprocessing import Pool, Value, Manager, Lock
         counter = Value('i', 0) # Globally accessible, defined in __main__ function. 'i' represents integer

         # Dictionary Initializations
         manager = Manager()
         word_dict = manager.dict()
         lemma_dict = manager.dict()
         pos_dict = manager.dict()

         # Locks Initializations
         l1 = Lock()
         l2 = Lock()

         # In the function which is going to be called by multiple processes
         l1.acquire()
         counter.value += 1
         l1.release()

         l2.acquire()
         word_dict[word] = len(word_dict) + 1
         lemma_dict[lemma] = len(lemma_dict) + 1
         pos_dict[word] = len(pos_dict) + 1
         l2.release()

   * **Note**: The :code:`manager.dict()` are dummy dictionaries. You cannot dump them as simple pickle objects and expect to work like normal python dictionaries when you pickle-load them again!! Therefore, write aconverter script to convert them into normal python dictionaries and then pickle-dump them.

* I have personally encountered **some issues** while using
  :code:`multiprocessing` with :code:`nltk` on my mac. However, the same code
  with the same :code:`nltk` version runs on ubuntu. There are many others who
  have expressed similar concerns (incompatability of :code:`nltk` and
  :code:`multiprocessing`)


Numpy
=====

* You can check if a numpy array contains :code:`nan` or :code:`inf` values.
  Usually, such arrays are problematic
      
    .. code-block:: python

      import numpy as np
      aa = np.array ([1,3,4])
      bb = np.array ([1,0,0])
      cc = aa / bb # Raises divide by zero encountered exception
      np.isnan(cc).any() # Checks for Nan values in array.
      np.isinf(cc).any() # Checks for Inf values in array.


Python HTTP requests
====================

* I have used HTTP Post request to run the DBpedia spotlight

    .. code-block:: python

      import urllib3
      import json
      import requests

      headers = {'Accept': 'application/json'}
      url = 'http://localhost:2222/rest/disambiguate'
      data = {"text" : '<annotation text="Keep us posted, Carlleton. Similar
      problem here. I managed to get my D up after 70 months of high dose
      supplement, but after two years have now dropped Back into the land of
      Osteomalacia"> <surfaceForm name="Back" offset="152">
      </surfaceForm><surfaceForm name="Osteomalacia"
      offset="174"></surfaceForm></annotation>'}
      r = requests.post(url, data=data, headers=headers)
      print (r.text)

* Note: For calling :code:`GET` requests use :code:`requests.get` function.
  While calling :code:`GET` function, make sure to change the header key to
  :code:`Content-Type` instead of :code:`Accept`.


Sacred
======

* :code:`Sacred` is a useful tool in python for parameter sweeping experiments.
* :code:`pip install sacred`
* It stores all the information about an experiment run in a MongoDB. For that
  you need to setup MongoDB on your system and also have `pymongo` installed.
  More help is available `here <http://sacred.readthedocs.io/en/latest/quickstart.html>`__


Other Packages
--------------

* One of the useful aspects of python is :code:`pickle`. I had pickled huge word vectors file and loading it back took less than 10 seconds.
* A super awesome feature in python is the ability to pickle objects. However, you cannot pickle lambda functions or objects that depend on lambda function. The reason for this is that functions are pickled by name, not by code. Unpickling will only work if a function with the same name is present in in the same module. This is why pickling a lambda won't work: they have no individual names.
* One useful package for printing python output in multiple colors is
  :code:`termcolor`
  :code:`conda install -c omnia termcolor`

    .. code-block:: python

      from termcolor import colored
      print (colored('Hello','green'))

* There is this cool plugin in ipython notebooks called `storemagic
  <https://ipython.org/ipython-doc/3/config/extensions/storemagic.html>`_ to
  persist python objects which are **picklable**.
