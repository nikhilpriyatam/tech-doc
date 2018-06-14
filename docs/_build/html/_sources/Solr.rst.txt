Solr
====

* Zookeeper is very similar to hadoop in spirit and Solr in very similar to
  Nutch in spirit

* **Note**: Apache solr comes with a default zookeeper, never use it. Always,
  use an external zookeeper by following the below mentioned steps.

* Setting a zookeeper ensemble (On different machines) - Refer
  * `here <https://cwiki.apache.org/confluence/display/solr/Setting+Up+an+External+ZooKeeper+Ensemble>`_
  * Assume that you have 3 servers: 10.2.4.120, 120.2.4.122, 10.2.4.126.

  * Modify the :code:`/etc/hosts` file in all the 3 systems and include the lines 

    * :code:`10.2.4.120 solr1`
    * :code:`10.2.4.122 solr2`
    * :code:`10.2.4.126 solr3`

  * Install zookeeper in :code:`/opt/zookeeper/` on all 3 machines
  * Create a folder called data in `/opt/zookeeper/` on all 3 machines
  * In the folder :code:`/opt/zookeeper/data` create a file called myid on all 3
    machines. The content of myid on machine 1 (solr1) should be 1. The content
    of myid on machine 2 (solr2) should be 2. The content of myid on machine
    3 (solr3) should be 3.

  * You will have a :code:`zoo.cfg` in :code:`/opt/zookeeper/conf/zoo.cfg`. For
    the first server, called solr1, It will look like the following::
    
        dataDir=/opt/zookeeper/data
        clientPort=2181
        initLimit=5
        syncLimit=2
        server.1=0.0.0.0:2888:3888
        server.2=solr2:2888:3888
        server.3=solr3:2888:3888

    For other servers, it will be similar. The only difference would be: for
    server ‘x’, the :code:`server.x=0.0.0.0:2888:3888`

  * Go to :code:`/opt/zookeeper` folder and execute the following command on all 3 machines.

  * :code:`sudo ./bin/zkServer.sh start` [OPTIONAL CONF FILE: Default is
    :code:`/opt/zookeeper/conf/zoo.cfg`]. This should start the zookeeper on all the 3 machines.

  * You should check if the zookeeper has started properly on all the 3 machines by issuing the following commands:

    * :code:`sudo ./bin/zkServer.sh status`
    * If your zookeeper was running properly, You should see some output like::
      
           JMX enabled by default
           Using config: /opt/zookeeper/bin/../conf/zoo.cfg
           Mode: follower

      The last line might also be :code:`Mode: leader` . If there is an error
      then the last line would be something like “may be zookeeper is not even
      running”

  * You can stop the zookeeper by issuing the following command on all the 3
    systems: :code: `sudo ./bin/zkServer.sh stop` 

  * :code:`./bin/zkClient.sh` - This will take you to zookeeper mode where you
    have a set of limited choices available. Type help it will show what all
    choices you have.

  * Note 1: It does not mean that, if you have 3 machine, you have to use
    exactly 3 zookeeper instances, you can have more or less.

* Setting up Solr cloud (On different machines) - Help is
  `here <https://cwiki.apache.org/confluence/display/solr/Solr+Start+Script+Reference>`__

  * Assume that you have the same 3 servers: 10.2.4.120, 120.2.4.122, 10.2.4.126
    where zookeeper was also running

  * Assume that, your :code:`/etc/hosts` is already modified as described in step 2 of
    zookeeper setup (above)

  * Install solr in :code:`/opt/solr/` on all 3 machines.

  * If you had already run solr before and created a collection (e.g. wikipedia)
    and core (like wikipedia_shard1_replica1 or wikipedia_shard2_replica1) and
    you want to run search on those cores, issue the following command on
    any system or all system [depends on individual case under consideration]

  * :code:`bin/solr start -c -h solr3 -p 8983 -s collections_Home/solr/ -z
    solr1:2181,solr2:2181,solr3:2181 -m 2g`

    * :code:`-c` option denotes cloud mode
    * :code:`-h` option denotes hostname of machine on which you are running this [e.g. solr1, localhost, etc]
    * :code:`-p port` where you want to run this solr instance
    * :code:`-s solr_home_folder` or place where your collections/cores are
      located. Typically, this folder has one or more cores (which are also
      folders) like wikipedia_shard1_replica1 or wikipedia_shard2_replica1.
      It must contain a solr.xml file!! It might also contain a conf dir
    * :code:`-z` this is the zookeeper ensemble which we have set up previously.
    * :code:`-m` Java Memory that solr might take
    * **Note** Collection and cores are one and the same, depending on whether
      we are running solr on cloud mode or standalone mode. We have
      Collections (in SolrCloud mode) or cores (in standalone mode)

  * Creating solr collections or cores

    * :code:`bin/solr -c collection_name -d conf_dir -n config_name -p port -s
      num_of_shards -rf num_of_replicas`
    * :code:`-c` : Default is gettingstarted. The default final collection
      folders are stored in folders like :code:`example/cloud/node1/solr`
    * :code:`-d` : Default it data_driven_schema_configs
    * :code:`-n` : Configuration name. Default is same name as core or collection.
    * :code:`-p` : Port. By default the script tries to detect the port by
      looking for running Solr instances.
    * :code:`-s` : Number of shards. Default is 1.
    * :code:`-rf`: Number of replicas. Default is 1.

* If you don't provide the :code:`-d` or :code:`-n` options, then the default
  * configuration

    :code:`$SOLR_HOME/server/solr/configsets/data_driven_schema_configs/conf` is
    uploaded to ZooKeeper using the same name as the collection (under
    :code:`/configs/collection_name` in Zookeeper).

* Note: The :code:`data_driven_schema_configs` schema can mutate as data is
  indexed. Consequently, we recommend that you do not share data-driven
  configurations between collections unless you are certain that all
  collections should inherit the changes made when indexing data into one
  of the collections.

* Deleting solr collections or cores
    * :code:`bin/solr delete -c core_or_collection_name -deleteConfig true|false
      -p port`
    * :code:`-delteConfig` : Deletes the corresponding directory from ZooKeeper.
      Default is true. If the configuration directory is being used by another
      collection, then it will not be deleted even if you pass
      :code:`-deleteConfig true`.
    * **Note**: Several of the things mentioned here [and much much more] can
      also be done using API calls. Refer
      `here <https://cwiki.apache.org/confluence/display/solr/Collections+API>`__
    * Useful scripts that integrate solr with zookeeper
      `reference <https://cwiki.apache.org/confluence/display/solr/Command+Line+Utilities>`__

* We have a very useful script shipped with solr which is present in the
  directory :code:`/opt/solr/server/scripts/cloud-scripts/zkcli.sh`. It can be
  used to upload a new configuration onto the zookeeper (which would
  eventually go under :code:`/configs/dir_name` in zookeeper)

* **Note**: This script is also present in the :code:`zookeeper_home/bin`
  directory. Use this one in case you are using a zookeeper ensemble.

* :code:`./server/scripts/cloud-scripts/zkcli.sh -cmd upconfig -confdir
  config_dir_to_upload -confname configuration_name_you_wish_to_give -z
  solr1:2181,solr2:2181,solr3:2181`

* It can also be used to link a collection [present in zookeeper] with a
  configuration [also present in a zookeeper]

* :code:`./server/scripts/cloud-scripts/zkcli.sh -cmd linkconfig -collection
  collection_name -confname configuration_name_in_zookeeper -z
  solr1:2181,solr2:2181,solr3:2181`

* Status update in solr
  * :code:`bin/solr status`
  * :code:`bin/solr healthcheck -c collection_name -z zookeeper_host`
  * Use :code:`bin/solr stop -p [port_number or all]`

* To delete all the documents index in the core issue the following command in the browser:
  * `http://host_name:port_name/solr/core_name_with_shardId_and_replica_id/update?stream.body=\<delete\>\<query\>*:*\</query\>\</delete\>&commit=true`

  * E.g:
    `http://localhost:8984/solr/twitter_unprocessed_shard1_replica1/update?stream.body=%3Cdelete%3E%3Cquery%3E*:*%3C/query%3E%3C/delete%3E&commit=true`

  * There are other ways of deleting documents as well (currently, this seems to
    be the simplest). Note that, this deletes the indexed documents in a core
    and NOT the core itself.
