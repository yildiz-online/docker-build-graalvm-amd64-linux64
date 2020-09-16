FROM ubuntu:20.04

LABEL maintainer="Grégory Van den Borre vandenborre.gregory@hotmail.fr"

ENV GRAALVM_VERSION=20.2.0
ENV MAVEN_VERSION=3.6.3

ENV JAVA_FILE=graalvm-ce-java11-${GRAALVM_VERSION}
ENV JAVA_HOME=/${JAVA_FILE}
ENV M2_HOME=/apache-maven-${MAVEN_VERSION}
ENV PATH="${PATH}:${JAVA_HOME}/bin:${M2_HOME}/bin"

RUN apt-get update && install -y -q wget unzip

RUN wget -q https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.zip \
&& unzip graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.zip \
&& java -version \
&& rm graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.zip \
&& wget -q https://apache.belnet.be/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& rm apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& mvn -v \
&& apt-get purge -y -q wget

RUN gu install native-image
