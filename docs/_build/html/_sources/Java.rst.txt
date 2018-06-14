Java
====

* Compiling and executing JAVA programs from command line.

  * :code:`javac -classpath lib/\* src/*.java` [To compile class files with
    including some jar files]
  * :code:`java -classpath .:PATH_TO_LIB_FOLDER/\*
    NAME_OF_CLASS_FILE_WITHOUT_EXTENSION` [To execute a java class file
    including some jar files]
  * **Note**: In the above command, the dot ('.') was included so that all the
    class files present in the current directory could be used while executing
    the class.

* Avoid 3rd party Jars printing to your console.

  * If you want to avoid 3rd party jars printing log messages in your console,
    then you can print their output to a dummy console in the following way::
	
        PrintStream originalStream = System.out;
	PrintStream dummyStream = new PrintStream(new OutputStream()
	{
    	  public void write(int b)
    	  {
	    //NO-OP
    	  }
	});
	System.setOut(dummyStream);
	//You want to stop printing from here onwards
   		....
   		....
	System.setOut(originalStream);
	// You want to resume printing now

* `Help For Fixing Memory Leaks in Java
  <http://developers.redhat.com/blog/2014/08/14/find-fix-memory-leaks-java-application/>`_
