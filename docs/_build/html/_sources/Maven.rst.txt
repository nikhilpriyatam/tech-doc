Maven
=====

* Maven Proxy can be set / unset in 2 places
  * :code:`~/.m2/settings.xml`
  * :code:`$MAVEN_HOME/conf/settings.xml`

* Install a 3rd Party Jar in Maven

  * Go to the main folder of the project containing th "pom.xml" file and
    execute the following command

  * :code:`mvn install:install-file -Dfile=path-to-file -DgroupId=group-id \
    -DartifactId=artifact-id -Dversion=version -Dpackaging=packaging`

* :code:`mvn install:install-file -Dfile=path-to-file -DpomFile=path-to-pomfile`
  [Installation through pom file]

* :code:`mvn install:install-file -Dfile=path-to-file` [Installation through pom
  file above v2.5 of maven-install-plugin]

* To execute a particular class in Maven

  * :code:`mvn clean`
  * :code:`mvn compile`
  * :code:`screen mvn exec:java
    -Dexec.mainClass="in.iiith.siel.data_processing.FilterTweetsSolrQueries" \
    -Dexec.args="arg1 arg2 arg3"`

* :code:`export MAVEN_OPTS="-Xms1G -Xmx25G -XX:PermSize=1G"` [To set the JVM
  memory, in Maven]

