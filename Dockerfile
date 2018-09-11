FROM debian:wheezy

LABEL maintainer="Kehao Chen <kehao.chen@happyhacking.ninja>"

ARG JAVA_8_INSTALL_URL=https://github.com/AdoptOpenJDK/openjdk8-releases/releases/download/jdk8u172-b11/OpenJDK8_x64_Linux_jdk8u172-b11.tar.gz
ARG JAVA_9_INSTALL_URL=https://github.com/AdoptOpenJDK/openjdk9-binaries/releases/download/jdk-9.0.4%2B11/OpenJDK9U-jre_x64_linux_hotspot_2018-08-08-15-47.tar.gz
ARG MAVEN_INSALL_URL=http://ftp.tc.edu.tw/pub/Apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
ARG GRADLE_INSTALL_URL=https://services.gradle.org/distributions/gradle-4.10-bin.zip

# Install Java, Maven and Gradle.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y curl unzip && \
  apt-get install -y openjdk-6-jdk openjdk-7-jdk &&\
  curl -SL ${JAVA_8_INSTALL_URL} -o openjdk8.tar.gz && \
  curl -SL ${JAVA_9_INSTALL_URL} -o openjdk9.tar.gz && \
  tar -xzf openjdk8.tar.gz -C /usr/lib/jvm && \
  tar -xzf openjdk9.tar.gz -C /usr/lib/jvm && \
  update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk8u172-b11/bin/java 9000
RUN \
  curl -SL ${MAVEN_INSALL_URL} -o maven.tar.gz && \
  mkdir -p /opt/maven && \
  tar -xzf maven.tar.gz -C /opt/maven && \
  curl -SL ${GRADLE_INSTALL_URL} -o gradle.zip && \
  mkdir -p /opt/gradle && \
  unzip -d /opt/gradle gradle.zip && \
  rm -rf /var/lib/apt/lists/*

# Define working directory.
WORKDIR /data

# Define commonly used Java variables.
ENV JAVA_HOME /usr/lib/jvm/jdk8u172-b11
ENV JAVA_6_HOME /usr/lib/jvm/java-6-openjdk-amd64
ENV JAVA_7_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV JAVA_8_HOME /usr/lib/jvm/jdk8u172-b11
ENV JAVA_9_HOME /usr/lib/jvm/jdk-9.0.4+11-jre
ENV M2_HOME /opt/maven/apache-maven-3.5.4
ENV GRADLE_USER_HOME /opt/gradle/gradle-4.10
ENV PATH ${M2_HOME}/bin:${GRADLE_USER_HOME}/bin:${PATH}

RUN echo $PATH

# Define default command.
CMD ["bash"]