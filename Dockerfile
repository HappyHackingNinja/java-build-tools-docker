FROM centos:7

LABEL maintainer="Kehao Chen <kehao.chen@happyhacking.ninja>"

ARG USER_HOME_DIR="/root"
ARG MAVEN_VERSION=3.6.0
ARG GRADLE_VERSION=5.3.1
ARG MAVEN_INSALL_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
ARG GRADLE_INSTALL_URL=https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip

# Install Java, Maven and Gradle.
RUN \
  yum -y update && \
  yum install -y curl unzip && \
  yum install -y java-1.6.0-openjdk-devel java-1.7.0-openjdk-devel java-1.8.0-openjdk-devel && \
  yum clean all
RUN \
  curl -SL ${MAVEN_INSALL_URL} -o maven.tar.gz && \
  mkdir -p /usr/share/maven && \
  tar -xzf maven.tar.gz -C /usr/share/maven --strip-components=1 && \
  curl -SL ${GRADLE_INSTALL_URL} -o gradle.zip && \
  unzip gradle.zip && \
  mv "gradle-${GRADLE_VERSION}" /usr/share/gradle && \
  rm maven.tar.gz gradle.zip && \
  ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
  ln -s /usr/share/gradle/bin/gradle /usr/bin/gradle

# Define working directory.
WORKDIR /data

# Define commonly used Java variables.
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0
ENV JAVA_6_HOME /usr/lib/jvm/java-1.6.0
ENV JAVA_7_HOME /usr/lib/jvm/java-1.7.0
ENV JAVA_8_HOME /usr/lib/jvm/java-1.8.0
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV GRADLE_HOME /user/share/gradle

RUN echo $PATH

# Define default command.
CMD ["bash"]
