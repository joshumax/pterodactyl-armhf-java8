#
# Oracle Java 8 Dockerfile for ARMv7
#
# Derived from 
# https://github.com/dockerfile/java
# https://github.com/dockerfile/java/tree/master/oracle-java8
#

FROM armv7/armhf-ubuntu:14.04.3

# Install Java.
RUN apt-get -y update
RUN apt-get -y update
RUN apt-get -y install software-properties-common

RUN adduser -D -h /home/container container

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get -y install oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define working directory.
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container
	
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define default command.
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
