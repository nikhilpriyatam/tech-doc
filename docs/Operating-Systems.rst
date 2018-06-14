Operating Systems
=================

OSX
---
* I don't know what caused it, but I am getting this error everytime I restart the computer

  * :code:`Core Telephony Trace File Error A file operation for CoreTelephony tracing
    has failed, you may be out of disk space. Details 'Error opening file
    /tmp/ct.shutdown, err = Operation not permitted`

  * I solved this bug using the following technique:

    * Boot mac in recovery mode.
      * Start / restart the machine
      * When you hear login sound press and hold the :code:`Cmd + R keys` (simultaneously)
      * Release the keys when you see the recovery screen (Not the usual apple logo !!)
      * Login might take slightly more longer than usual.

    * Select Utilities -> terminal and execute the following command
    * :code:`csrutil disable`
    * Then restart the machine. The error was gone. Again go to recovery mode and execute
    * :code:`csrutil enable`
    * Again restart the machine.

* I also faced the following error while installing torch dependencies

  * :code:`hdiutil: mount failed - no mountable file systems`
  * I fixed the bug using the same procedure as above.

    * To boot mac in safe mode.
    * Start / restart the machine
    * When you hear login sound press and hold the shift key
    * Release the shift key when you see the apple logo
    * Login might take slightly more longer than usual.

* When, I tried to run bin/nutch readseg, I got the error "Error: JAVA_HOME is not set". However, it was set in ~/.bashrc. Then I executed the following command and things looked fine from then onwards.
  * :code:`export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_122.jdk/Contents/Home`

* When you ssh from your mac to a linux machine, you might see the following error/warning:  
  * :code:`Cannot set LC_CTYPE to default locale: No such file or directory.`
  * To fix it, goto iTerm --> Profiles --> Open Profiles --> Default Profile --> Edit Profiles --> Terminal --> Uncheck set environment variables automatically.


Ubuntu
------

* If you get the following error while running :code:`sudo apt-get update`

  * :code:`W: GPG error: http://ppa.launchpad.net trusty Release: The following
    signatures couldn't be verified because the public key is not available:
    NO_PUBKEY 82EB5823F4FE239D`

  * Then, set :code:`$http_proxy` and execute the following command.

  * :code:`sudo apt-key adv --keyserver-options http-proxy=$http_proxy --keyserver keyserver.ubuntu.com --recv 82EB5823F4FE239D`

General
-------

* You can upload data to `google drive` using `ssh` by using `gdrive` following

  * the process mentioned `here
    <http://olivermarshall.net/how-to-upload-a-file-to-google-drive-from-the-command-line/>`__.

* If you ssh into a server and then do :code:`sudo -u some-user-name -i` then you cannot use "screen command".

  * To use the screen command issue the following command while you are logged in as some-user-name
    :code:`script /dev/null`

  * The user who executes this command, basically owns the shell.

* To add a user in the linux environment and to give him sudo access
  * :code:`cat /etc/passwd` gives the set of all users in the given machine
  * :code:`sudo adduser user_name` - Fill in the required details
  * :code:`sudo adduser user_name sudo` - Gives sudo permission to the user

* To increase the priority of a process use the following command:
  * :code:`renice -n nice_value -p process_id`
  * A nice_value of -20 means highest priority, default is 0

* While deleting or removing a large number of files. You might face the error:
  * :code:`gnubin/rm: Argument list too long.` In that case, use the
    :code:`xargs`
  * :code:`find . -maxdepth 2 -name "\*.txt" -print0 | xargs -0 rm`

* Command to delete empty files from a directory :code:`find . -empty -type f -delete`

* :code:`cp, scp or sftp error: "File too large".` It might be a limit problem, which can be set from the command line.
  * check file transfer limit: `ulimit -a`
  * Or check if your disk [to which you are copying is formatted in FAT32 or ext3]. ext4 is good.

* To perform a multi-threaded download on a Linux based machine - use "axel"
  command. :code:`axel -n 1000 url`. Where 1000 is the number of threads.

* To use terminal as a browser [Extremely helpful for remote logins]
  :code:`sudo apt-get install w3m w3m-img`
  * To open a webpage simply type in a terminal window: :code:`w3m URL-of-the-webpage`
  * To go back one page: :code:`Shift-B`
  * To open a new tab: :code:`Shift-T`

  * To click a link: Navigate to the relevant portion using cursor / mouse and
    press **Enter**

  * To enter credentials like username and password, navigate to relevant
    portion and press **Enter**

  * Press :code:`Q` to quit
  * More help is available `here <http://w3m.sourceforge.net/MANUAL>`__
  * :code:`w3m` can also be run using screen: :code:`screen -L w3m URL-of-the-webpage`

ldconfig
--------

* :code:`ldconfig` is a program that is used to maintain the shared library cache.
* This cache is typically stored in the file :code:`/etc/ld.so.cache` and is
  used by the system to map a shared library name to the location of the
  corresponding shared library file.
* This is used when a program is executed to find locations of shared libraries
  that need to be dynamically loaded and linked to the program.
* By default, the shared library files in :code:`/lib`, :code:`/usr/lib` and a few other
  * standard directories are maintained in the cache by :code:`ldconfig`
* A new program or library might be installed in a non-standard directory, for
  * example in :code:`/opt/foobar/lib`. Programs that need the shared libraries from this library might fail with this error when executed.
* To fix this problem, we need to add the library directory to the list used by
  :code:`ldconfig`. There are two ways to do this:
  * Add to :code:`LD_LIBRARY_PATH`  (Example :code:`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/foobar/lib` in `~/.bashrc`)

  * Rebuild cache by executing wither of the following commands :code:`ldconfig` or
    :code:`ldconfig -v` (verbose).

  * To check if the shared library cache now includes the shared libraries from the new directory use `ldconfig -p`
    A detailed description is `here <https://codeyarns.com/2014/01/14/how-to-add-library-directory-to-ldconfig-cache/>`__


Installing Apache2 on ubuntu
----------------------------

* Most basic usage: You can setup a simple file server which can serve files to users accessing your IP.
* Installation
  * :code:`sudo apt-get install apache2`
  * **Scenario 1**: You want to setup multiple virtual hosts on the same machine.

      * Edit the :code:`/etc/hosts` file and include the hosts in the following
	manner

	.. code-block:: sh

        127.0.0.1 localhost
        127.0.0.1 myhost1
        127.0.0.1 myhost2

      * Although, there are other places where you can add configurations. I
	have made all configuration changes in the following file -
	:code:`/etc/apache2/sites-enabled/000-default.conf`::

          <VirtualHost *:80>
          ServerName myhost1
    	  ServerAdmin my@emailid.com
          # The place where the index.html exists
    	  DocumentRoot /home/i1392424/Tools/brat-v1.3_Crunchy_Frog

	  # Directory specific permissions
          <Directory /home/i1392424/Tools/brat-v1.3_Crunchy_Frog>
       	  	
	  	AllowOverride Options Indexes FileInfo Limit
          	AddType application/xhtml+xml .xhtml
          	AddType font/ttf .ttf

    	  </Directory>

    	  ErrorLog ${APACHE_LOG_DIR}/error.log
    	  CustomLog ${APACHE_LOG_DIR}/access.log combined
          </VirtualHost>
      	
          <VirtualHost \*:80>
          # The server name should be defined in /etc/hosts
          ServerName myhost2
    	  ServerAdmin my@emailid.com
          # The place where the index.html exists
    	  DocumentRoot /this/is/another/folder
          # Directory specific permissions
          <Directory /this/is/another/directory>
        	AllowOverride Options Indexes FileInfo Limit
        	AddType application/xhtml+xml .xhtml
        	AddType font/ttf .ttf
    	  </Directory>
    	  ErrorLog ${APACHE_LOG_DIR}/error.log
    	  CustomLog ${APACHE_LOG_DIR}/access.log combined
          </VirtualHost>

      * After you change configuration execute the command :code:`sudo service
	apache2 restart` or :code:`apache2 restart`
      * You can now access your stuff from your browser :code:`http://myhost1`
	or :code:`http://myhost2`
      * **Disadvantage**: The main disadvantage of this approach is that, while
	you can have multiple virtual hosts configured for multiple projects -
	Other people (within the same network) cannot access all these
	applications. They can only access the application hosted on the
	default port 80. For this reason, we might prefer hosting one
        application per host, which brings us to **Scenario 2**.

    * **Scenario 2**: You want to setup multiple applications on the `localhost`
      itself. Add the following to :code:`/etc/apache2/sites-available/000-default.conf`

         .. code-block:: sh
         <VirtualHost \*:9001>
         # The server name should be defined in /etc/hosts
         ServerName localhost
    	 ServerAdmin my@emailid.com
         # The place where the index.html exists
    	 DocumentRoot /home/i1392424/Tools/brat-v1.3_Crunchy_Frog
         # Directory specific permissions
         <Directory /home/i1392424/Tools/brat-v1.3_Crunchy_Frog>
        		  AllowOverride Options Indexes FileInfo Limit
        		  AddType application/xhtml+xml .xhtml
        		  AddType font/ttf .ttf
    	 </Directory>
    	 ErrorLog ${APACHE_LOG_DIR}/error.log
    	 CustomLog ${APACHE_LOG_DIR}/access.log combined
         </VirtualHost>


         <VirtualHost \*:9002>
         # The server name should be defined in /etc/hosts
         ServerName localhost
    	 ServerAdmin my@emailid.com
         # The place where the index.html exists
    	 DocumentRoot /this/is/another/folder
         # Directory specific permissions
         <Directory /this/is/another/directory>
        		AllowOverride Options Indexes FileInfo Limit
        		AddType application/xhtml+xml .xhtml
        		AddType font/ttf .ttf
    	 </Directory>
    	 ErrorLog ${APACHE_LOG_DIR}/error.log
    	 CustomLog ${APACHE_LOG_DIR}/access.log combined
         </VirtualHost>
         # Opening the ports for listening, very improtant
         Listen 9001
         Listen 9002

      * After modifying the conf file, execute one of the following commands `sudo service apache2 restart` or `apache2 restart`.
      * Now others can connect to the respective applications from their browsers using `http://your-local-ip:9001` and `http://your-local-ip:9002`
      * General notes
        * Do not have `Listen <Port-ID>` command in 2 places - `ports.conf`, `sites-available/something.conf`
        * You can also create multiple files under `sites-available` like `sites-available/something.conf`. In that case you need to activate the site using the command `sudo a2ensite something.conf`

  * uTorrent (read mu-torrent) is a good software to download large files from torrent. If you are using command line, then use `deluge`
    * :code:`sudo apt-get install deluge deluged deluge-console`
    * Run :code:`deluged`
    * Run :code:`deluge-console`

FTP Server related instructions
-------------------------------

  * You can use a tool called :code:`FileZilla` as a ftp client. It is useful for downloading as well as uploading files into an ftp server.
  * To transfer directories to an FTP server from a command line, follow the below outlined instructions.
    * Install :code:`lftp` in ubuntu
    * :code:`lftp <server-ip>`
    * :code:`user <nikhil.pattisapu>`
    * :code:`set ssl:verify-certificate no`
    * :code:`mirror -R <path-to-local-dir> <path-to-server-dir>`
	
  * To transfer individual file to an FTP server from a command line, follow the instructions outlined below.
    * :code:`lftp <server-ip>`
    * :code:`user <nikhil.pattisapu>`
    * :code:`set ssl:verify-certificate no`
    * :code:`ls`
    * :code:`cd <server-target-directory>`
    * :code:`put <host-source-directory>`
