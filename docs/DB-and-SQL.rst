Databases
=========

sqlite3
-------

* I am using :code:`sqlite3` for storing in databases. You can write to or read
  from this DB from python ialso.
* Some basic commands are mentioned below with examples.
  * Go to sqlite console :code:`sqlite3`
  * Create DB :code:`sqlite3 <DB_NAME>`
  * Check existing DB [In sqlite console]: :code:`.databases`
  * Quit [In sqlite console]: :code:`.quit`
  * List tables [In sqlite console]: :code:`.tables`

  * Create table [In sqlite console]: :code:`CREATE TABLE basic_post(post_id
    TEXT PRIMARY KEY NOT NULL, post_content TEXT, post_topic TEXT);`

  * To get a particular tables information [In Sqlite console]: :code:`PRAGMA
    table_info(<TABLE_NAME>);`

  * :code:`select count(*) from <table_name>` to get total number of rows.
  * :code:`SELECT * FROM <table_name> LIMIT 5;` to get top 5 rows of the table.
  * :code:`delete from <table_name>;` to delete all rows in a table.
  * :code:`SELECT * FROM <table_name> ORDER BY RANDOM() LIMIT 100;` to select
    random rows from a table.
  * :code:`ALTER TABLE <table_name> RENAME TO <another_table_name>` to rename a
    table.
  * :code:`Ctrl + L` to clear the sqlite console

  * If you want to copy a table from one database to another then use the
    `attach` command first:

    * :code:`attach database 'db/contacts.db' as contacts;`
    * :code:`INSERT INTO <current_db.table_name> SELECT * FROM
      <contacts.table_name>;`

* What to do if you get the error of the kind :code:`Error: near line 1:
  database is locked`

  * Find the processes that are locking the database using command :code:`fuser
    <DB_NAME>`
  
  * Kill those processes using the command :code:`kill -9 <p_id>`


Postgres
--------

* There is a known bug in starting postgres server in Mac. Basically, running
  :code:`psql postgres` throws up the following error
  :code:`psql: could not connect to server: No such file or directory
  Is the server running locally and accepting connections on Unix domain
  socket "/tmp/.s.PGSQL.5432"?`

* To fix this use the following commands to manually start and stop the postgres
  servers. More information here.

  * :code:`pg_ctl -D /usr/local/var/postgres -l
    /usr/local/var/postgres/server.log start`

  * :code:`pg_ctl -D /usr/local/var/postgres stop -s -m fast`

* To enter the postgres command line utility use the command :code:`psql
  postgres` OR :code:`psql -U mimic`
* To exit the postgres command line utility use the command - Type `\q` and then
  press ENTER to quit psql.

* On Linux machine, psql postgres results in the following error::

    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = (unset),
    LC_CTYPE = "UTF-8",
    LANG = "en_US.UTF-8" are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    psql: FATAL:  role "USER_NAME" does not exist

* To fix this use the following command
    * :code:`sudo -u postgres createuser -s USER_NAME`
    * :code:`sudo -u postgres -i`

* Sometimes we get the error, Peer authentication failed for user "USER_NAME"
  * Edit the file :code:`/etc/postgresql/9.1/main/pg_hba.conf`
  * Add the line :code:`local all mimic trust`
  * :code:`/etc/init.d/postgresql restart` to restart the postgresql server


* Some useful commands for using postgres sql are given below
  * :code:`\list` [Lists all databases]
  * :code:`\connect mimic` [Connect to the appropriate database]
  * :code:`\dt \*.` [Lists all the table in the databases]   
  * :code:`SELECT * FROM Table_Name ORDER BY subject_id ASC LIMIT 1`
  * :code:`\s` To see history of psql commands.
