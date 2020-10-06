FROM ubuntu:20.04
LABEL maintainer="Grégory Van den Borre vandenborre.gregory@hotmail.fr"

ENV GRAALVM_VERSION=20.2.0
ENV MAVEN_VERSION=3.6.3

ENV JAVA_FILE=graalvm-ce-java11-linux-amd64-dev
#ENV JAVA_FILE=graalvm-ce-java11-${GRAALVM_VERSION}
ENV JAVA_HOME=/graalvm-ce-java11-20.3.0-dev
ENV M2_HOME=/apache-maven-${MAVEN_VERSION}
ENV PATH="${PATH}:${JAVA_HOME}/bin:${M2_HOME}/bin"

RUN apt-get update && apt-get install -y -q wget build-essential libz-dev zlib1g-dev

#RUN wget -q https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz
#RUN tar -xzf graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz \
#&& rm graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz
RUN wget -q https://github.com/graalvm/graalvm-ce-dev-builds/releases/download/20.3.0-dev-20201006_0329/graalvm-ce-java11-linux-amd64-dev.tar.gz
RUN tar -xzf graalvm-ce-java11-linux-amd64-dev.tar.gz
RUN rm graalvm-ce-java11-linux-amd64-dev.tar.gz
RUN java -version

RUN wget -q https://apache.belnet.be/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& rm apache-maven-${MAVEN_VERSION}-bin.tar.gz \
&& mvn -v
RUN apt-get purge -y -q wget
RUN mkdir /src
RUN mkdir /build-resources

RUN gu install native-image

COPY build-native.sh build-resources
RUN chmod 777 /build-resources/build-native.sh

WORKDIR /src

ENTRYPOINT ../build-resources/build-native.sh
