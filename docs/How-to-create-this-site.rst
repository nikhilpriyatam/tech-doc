=======================
How to Create this site
=======================

For the First time
------------------

* Prerequisites - Need to have login credentials for `GitHub <github.com>`_ and
  `Readthedocs <readthedocs.org>`_
* System requirements: `pip install sphinx sphinx-autobuild`
* Login into GitHub and create an empty repository on GitHub, say `tech-doc`. 
* Login into readthedocs.org and click Import a repository and manually import
  the above GitHub repository
* Obtain `Payload URL`. Login into readthedocs and go to `Your
  project --> Admin --> Integrations --> Copy this URL using browser`.
* On GitHub, Configure the `readthedocs` web hook by `Project --> Settings -->
  WebHooks --> Add webhook --> Enter Payload URL --> Content type, both
  application/json and application/x-www-form-urlencoded work. --> Select just
  push the event --> Add Webhook`.
* Note: Webhooks inform readthedocs every time something is pushed to your
  GitHub repository. This helps readthedocs autobuild changes without your
  intervention. Otherwise, you will have to manually build the readthedocs
  project each time you want to see fresh changes.
* Create a new directory `docs` inside your project folder, say `~/git/tech-doc`
* `cd docs`
* `sphinx-quickstart` - This will walk you through basic configuration. When
  it's done, you’ll have an `index.rst`, a `conf.py` and some other files. 


Editing the website
-------------------

* Edit any of the existing file or Add/delete any .rst file
* Edit the `index.rst` file to include other `.rst` files in this folder. Be
  careful about format of `index.rst`. `sphinx` is very particular about this
  format
* Execute `make html`. This command will generate HTML files in `_build/html`
  folder. Inspect the HTML files using a web browser.
* Edit your files and rebuild until you like what you see, then commit your
  changes and push to your public repository.
* See the changes in `readthedocs --> My projects --> Project --> View your
  documentation`. You can use the URL to share this doc with others or store it
  for future use.


Additional Information
----------------------

* If you want to run a local instance of Read the docs, please follow `this
  page <http://read-the-docs.readthedocs.io/en/latest/install.html>`_
* Here is a good `starting point <https://thomas-cokelaer.info/tutorials/sphinx/rest_syntax.html#inline-markup-and-special-characters-e-g-bold-italic-verbatim>`_ to understand the syntax of reStructuredText and Sphinx. Here, you will also find how to write nice documentation for your python code.
