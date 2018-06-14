MetaMap
=======

* `MetaMap installation and Running <https://metamap.nlm.nih.gov/Docs/README.html>`_
* All the below 3 things are required to be installed,in the same order, in case
  you want to use Metamap server from Java Program with UIMA.
  * Metamap main
  * Metamap Java API
  * Metamap UIMA

* Allowing external hosts to access Metamap server

  * Go the folder (in server) where MetaMap is installed and edit the file
    :code:`./public_mm/bin/mmserver`, search for the following text in this file
    and edit it accordingly::

        if [ -z $ACCEPTED_HOSTS] ; then
        ACCEPTED_HOSTS="['127.0.0.1','10.2.4.235','10.4.17.149']"
	fi

* Change the -Xmx options in :code:`public_mm/bin/skrmedpostctl` and
  :code:`public_mm/bin/wsdserverctl` [For Increasing the memory of MetaMap server]


* Parsing Blogs or Clinical Texts

  * If you are parsing blogs or clinical texts which contain "newline"
    characters then replace them with a space (" ") before sending the input
    to MetaMap.

  * Although, there is another (a clean and preferred method given `here
    <https://metamap.nlm.nih.gov/Docs/FAQ/ClinicalText.pdf>`__, `here
    https://metamap.nlm.nih.gov/Docs/FAQ/MM_FAQ.pdf>`__ and `here
    https://metamap.nlm.nih.gov/Docs/MM_2016_Usage.pdf>`__ (use --blanklines N
    option), somehow, I did not find success with this approach)


* :code:`ps ax | grep java` [To determine if MetaMap is running]

* There is a cool python wrapper for MetaMap available
  `here <https://github.com/AnthonyMRios/pymetamap>`_.
  * This wrapper, in its current form works only for python 2.x
  * For making it work in python 3.x, I had to modify

    * :code:`/Users/nikhilpattisapu/miniconda2/envs/snakes/lib/python3.4/
      site-packages/pymetamap-0.1-py3.4.egg/
      pymetamap/__init__.py` file.

  * I added the following statements in that file and everything worked fine::
       
        import sys
        sys.path.append('/Users/nikhilpattisapu/git/pymetamap/pymetamap/')
	import Concept

* Metamap has some useful options which are of interest some of them are illustrated below.
  * :code:`-R SNOMEDCT_US,MEDLINE` (Restrict Sources)
  * :code:`-A` (Use strict model)
  * :code:`-J dsyn,sosy` (Restrict to semantic types)
  * :code:`-K` (ignore stop phrases).

* These options can be passed to MetaMap through command line
  * Worked for :code:`public_mm/bin/metamap16` but did not work for :code:`public_mm/bin/mmserver16`.

  * For using MetaMap as a server, I had run the
    :code:`public_mm/bin/mmserver16` on a different server and set the above
    useful options using MetaMap JavaAPI. An example snippet is shown below::
	
         // Include prologbeans.jar and MetaMapApi.jar
         MetaMapApi api = new MetaMapApiImpl();

         api.setHost("10.2.133.200");
         api.setPort(8066);
         List<String> theOptions = new ArrayList<String>();
         api.setOptions("-y"); // Use WSD
         theOptions.add("-A"); // Use strict model
         theOptions.add("-K"); // Ignore stop phrases

         theOptions.add("-J"); // Restrict to semantic types
         theOptions.add("dsyn,sosy"); // No space between arguments

         theOptions.add("-R"); // Restrict to Sources
         theOptions.add("SNOMEDCT_US,MEDLINEPLUS"); // No space between arguments

         if (theOptions.size() > 0)
         {
             api.setOptions(theOptions);
         }
         String input = "I do not want a heart attack." // Example text
         List<Result> resultList = api.processCitationsFromString(input);
