# Debianization for the Apache Kafka server

The repo contains so called DEBIAN directory with
scripts and configs needed to package the
[Apache Kafka](http://kafka.apache.org/) server
into a DEB package for the Debian Wheezy distro.

## Short DEB-packaging HowTo

1. Download the upstream tarball from the [Kafka site](http://kafka.apache.org/downloads.html);

2. Unpack the tarball:

```tar xf kafka-$version.tar.gz```

3. Copy the _debian_ dir into the upstream sources tree:

```cp -r /path/to/the/repo/debian ./kafka-$version/```

4. Create a source package:

```dpkg-source -b ./kafka-$version```

5. Build a binary DEB-package in a clean chrooted environment
(need to configure _pbuilder_ if not configured yet):

```sudo pbuilder --build kafka_$version-$release.dsc```

6. Include the source and the binary packages into a APT repository
(need to configure _reprepro_ if not configured yet):

```reprepro -b /path/to/apt/repo/dir/ include wheezy kafka_$version-$release.changes```

## Installing the Kafka server from the APT repository

```apt-get install kafka-daemon```

Directory layout:

* _/etc/kafka_ - configs;
* _/usr/lib/kafka/bin_ - helper scripts;
* _/var/lib/kafka_ - PID files and runtime data;
* _/var/log/kafka_ - log files.
