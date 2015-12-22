FROM jenkins

# install aditional plugins
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt

# copy jobs
COPY compile-hello-world.xml $JENKINS_HOME/jobs/compile-hello-world/config.xml
COPY setup-google-test.xml   $JENKINS_HOME/jobs/setup-google-test/config.xml

# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y cmake clang cppcheck && rm -rf /var/lib/apt/lists/*
# This chash execution --> USER jenkins # drop back to the regular jenkins user - good practice