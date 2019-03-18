Python
======

Use Ipython inside a Python Program
-----------------------------------

To inspect variables in a python script (which takes long to run), you can insert the following lines in your code to start an ipython kernel.

`from IPython import embed`
`embed() # Place this line somewhere in your program`

Anaconda or Pip
---------------
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
---------------
* Multiprocessing is a highly convenient option for parallel processing in
  python. The following is a sample script that takes a string list as input
  and modifies the strings in a parallel fashion.

* There are scenarios, where data needs to be shared between multiple threads
  (e.g. increment or decrement global variables).
  * If it is a counter, always try to pass counter values as additional inputs rather than sharing them between processes.

  * **Note** - Global variables are not shared between processes. We need
    special kinds of variables

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

  * **Note**: The :code:`manager.dict()` are dummy dictionaries. You cannot dump
    them as simple pickle objects and expect to work like normal python
    dictionaries when you pickle-load them again!! Therefore, write a
    converter script to convert them into normal python dictionaries and
    then pickle-dump them.

* I have personally encountered **some issues** while using
  :code:`multiprocessing` with :code:`nltk` on my mac. However, the same code
  with the same :code:`nltk` version runs on ubuntu. There are many others who
  have expressed similar concerns (incompatability of :code:`nltk` and
  :code:`multiprocessing`)


Documentation
-------------

* Always follow proper `documentation guidelines <https://realpython.com/documenting-python-code/>`_ .
* Use this `reStructuredText based python documentation example<https://thomas-cokelaer.info/tutorials/sphinx/docstring_python.html>`_
* Always follow `PEP 8M<https://pep8.org/>` guidelines while writing python code. It really helps in the long run.
* Although there are several Docstring formats. I prefer reStructuredText. It is short, simple and to the point.
* The above link also mentions about how to maintain you python project - Folder structure, content, documentation, etc.

Numpy
-----

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
--------------------

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
------

* :code:`Sacred` is a useful tool in python for parameter sweeping experiments.
* :code:`pip install sacred`
* It stores all the information about an experiment run in a MongoDB. For that
  you need to setup MongoDB on your system and also have `pymongo` installed.
  More help is available `here <http://sacred.readthedocs.io/en/latest/quickstart.html>`__


Other Packages
--------------

* One of the useful aspects of python is :code:`pickle`. I had pickled huge word vectors file and loading it back took less than 10 seconds.
* One useful package for printing python output in multiple colors is
  :code:`termcolor`
  :code:`conda install -c omnia termcolor`

    .. code-block:: python

      from termcolor import colored
      print (colored('Hello','green'))

* There is this cool plugin in ipython notebooks called `storemagic
  <https://ipython.org/ipython-doc/3/config/extensions/storemagic.html>`_ to
  persist python objects which are **picklable**.


Pickling in Python
------------------

* A super awesome feature in python is the ability to pickle objects. However, you cannot pickle lambda functions or objects that depend on lambda function. The reason for this is that functions are pickled by name, not by code. Unpickling will only work if a function with the same name is present in in the same module. This is why pickling a lambda won't work: they have no individual names.
