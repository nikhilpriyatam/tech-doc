Nutch
=====

* By default Nutch crawls only http pages, to extend it to https, you have to
  set the following property in :code:`conf/nutch-site.xml`::

  \<property\>
  \<name\>plugin.includes\</name\>
  \<value\>protocol-http|protocol-httpclient|urlfilter-regex|parse-(html|tika)|index-(basic|anchor)|indexer-solr|scoring-opic|urlnormalizer-(pass|regex|basic)\</value\>
  \<description\>Regular expression naming plugin directory names to
  include.  Any plugin not matching this expression is excluded.
  In any case you need at least include the nutch-extensionpoints plugin. By
  default Nutch includes crawling just HTML and plain text via HTTP,
  and basic indexing and search plugins. In order to use HTTPS please enable
  protocol-httpclient, but be aware of possible intermittent problems with the
  underlying commons-httpclient library. Set parsefilter-naivebayes for classification based focused crawler.
  \</description\>
  \</property\>

* One must also set proxy in the :code:`nutch-site.xml`
* If :code:`nutch-site.xml` is empty we could change the
  :code:`nutch-default.xml` file.
