# Debianization for the Apache Kafka server

The repo contains so called DEBIAN directory with
scripts and configs needed to package the
[Apache Kafka](http://kafka.apache.org/) server
into a DEB package for the Debian Wheezy distro.

The specs are adapted to pre-built Apache Kafka.

## Short DEB-packaging HowTo

1. Download the upstream tarball with pre-built Apache Kafka from the
 [Kafka site](http://kafka.apache.org/downloads.html);
 or use ``uscan`` to download automatically:

```uscan -v --download-current-version```

2. Unpack the tarball:

```tar xf kafka-$version.tar.gz```

3. Copy the _debian_ dir into the upstream sources tree:

```cp -r /path/to/the/repo/debian ./kafka-$version/```

4. Create a source package:

```dpkg-source -b ./kafka-$version```

5. Build a binary DEB-package in a clean chrooted environment
(need to configure _pbuilder_ if not configured yet):

```sudo pbuilder --build kafka_$version-$release.dsc```

6. Include the source and the binary packages into an APT repository
(need to configure _reprepro_ if not configured yet):

```reprepro include $suite kafka_$version-$release.changes```

## Installing the Kafka server from the APT repository

```apt-get install kafka```

Directory layout:

* _/etc/kafka_ - configs;
* _/usr/lib/kafka/bin_ - helper scripts;
* _/var/lib/kafka_ - PID files and runtime data;
* _/var/log/kafka_ - log files.
