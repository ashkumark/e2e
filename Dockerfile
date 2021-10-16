

FROM maven:3.8.3-openjdk-8

WORKDIR /home/docker-jenkins-test

COPY src /home/docker-jenkins-test/src
COPY pom.xml /home/docker-jenkins-test
COPY maventestrunner.sh /home/docker-jenkins-test

USER root

RUN apt-get update && \
    apt-get install -y sudo gnupg wget curl jq unzip bash --no-install-recommends

ENTRYPOINT ["/bin/sh"]
CMD ["maventestrunner.sh"]