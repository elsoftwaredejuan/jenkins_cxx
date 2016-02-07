FROM jenkins

# install aditional plugins
COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt

# copy jobs
COPY compile-hello-world.xml $JENKINS_HOME/jobs/compile-hello-world/config.xml
COPY setup-google-test.xml   $JENKINS_HOME/jobs/setup-google-test/config.xml

# if we want to install via apt
USER root

# Update apt-get
RUN apt-get update

# apt-utils contains the /usr/bin/apt-extracttemplates program which is used when 
# packages need to ask you questions about how to be configured. 
# This package being Priority: important, means it should really be installed
# see: http://serverfault.com/questions/358943/what-does-debconf-delaying-package-configuration-since-apt-utils-is-not-insta
RUN apt-get install -y apt-utils

RUN apt-get install -y source

# RUN apt-get update && apt-get install -y cmake clang cppcheck  libboost-all-dev  python-dev 
RUN apt-get update && apt-get install -y cmake clang cppcheck python-dev libbz2-dev

#install boost library
#RUN apt-get install -y libbz2-dev  libboost-python-dev libboost-test-dev  libboost-date-time-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libboost-iostreams-dev

# Install Boost
WORKDIR /tmp

#RUN curl -L "http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz/download" \
# | gunzip | tar -x && mv boost_1_60_0 boost \
# && cd boost && ./bootstrap.sh --with-toolset=clang && ./b2 -j4 && ./b2 install \
# && cd .. && rm -R boost

# Download boost
RUN curl -L "http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz/download" \
| gunzip | tar -x && mv boost_1_60_0 boost

# Go to boost folder
WORKDIR boost

# Configure boost
RUN ./bootstrap.sh --with-toolset=clang 

# Compile 
# http://stackoverflow.com/questions/12418838/how-to-compile-static-library-with-fpic-from-boost-python
RUN ./b2  cxxflags="-std=c++11 -fPIC" -j4

# Install boost
RUN ./b2 install 


RUN rm -rf /var/lib/apt/lists/*
# This chash execution --> USER jenkins # drop back to the regular jenkins user - good practice