FROM ubuntu:xenial
ENV DEBIAN_FRONTEND noninteractive
## Setting up build tools and utilities
RUN apt-get update -y
RUN apt-get install -y software-properties-common apt-utils
RUN apt-get update -y
RUN apt-get install -y build-essential g++
RUN apt-get install -y curl unzip nano
## JRE and Ant
RUN apt-get update
RUN apt-get install -y default-jre
RUN apt-get install -y default-jdk
RUN java -version
RUN javac -version
RUN apt-get install -y ant
RUN ant -version
## Python
RUN apt-get update
RUN apt-get install -y python-dev python-pip python-setuptools
RUN python --version
## libantlr3c
RUN curl -LO https://www.antlr3.org/download/C/libantlr3c-3.4.tar.gz
RUN tar xvzf libantlr3c-3.4.tar.gz
WORKDIR libantlr3c-3.4/
RUN ./configure --enable-64bit
RUN make
RUN make install
RUN ldconfig
WORKDIR /
RUN rm -rf libantlr3c-3.4/
RUN rm libantlr3c-3.4.tar.gz
## SWIG and PCRE
RUN apt-get update
RUN apt-get install -y libpcre3-dev libpcre++-dev
RUN curl -LO https://nchc.dl.sourceforge.net/project/swig/swig/swig-3.0.12/swig-3.0.12.tar.gz
RUN tar xzvf swig-3.0.12.tar.gz
WORKDIR swig-3.0.12/
RUN ./configure
RUN make
RUN make install
RUN ldconfig
WORKDIR /
RUN rm -rf swig-3.0.12/
RUN rm swig-3.0.12.tar.gz
## Jam
RUN apt-get update
RUN apt-get install -y bison flex
RUN apt-get install -y git
RUN git clone --depth=1 https://github.com/CaffeineHighZombie/europa-pso
WORKDIR europa-pso/ThirdParty/trunk
RUN mkdir jam
RUN cp jam-2.5.zip jam/
WORKDIR /europa-pso/ThirdParty/trunk/jam
RUN unzip jam-2.5.zip 
RUN make
WORKDIR /europa-pso/ThirdParty/trunk
RUN cp -a jam /usr/share/
RUN ln -s /usr/share/jam/jam0 /usr/bin/jam
## CppUnit
RUN tar xjvf cppunit-1.12.1.tar.bz2
WORKDIR /europa-pso/ThirdParty/trunk/cppunit-1.12.1/
RUN ./configure CXX="g++ -m64" LDFLAGS="-ldl"
RUN make 
RUN make install
RUN ldconfig
WORKDIR /
RUN rm -rf /europa-pso
## cmake
RUN apt-get update
RUN apt-get install -y cmake
## Boost Libraries
RUN apt-get update
RUN apt-get install -y libboost-all-dev
## doxygen and graphviz
RUN apt-get update
RUN apt-get install -y doxygen
RUN apt-get install -y python-pydot python-pydot-ng graphviz
## Europa
RUN git clone https://github.com/nasa/europa
WORKDIR /europa
RUN mkdir build
WORKDIR /europa/build
RUN cmake ..
RUN make
RUN make install
## Recreating Directory structure and files for planner usage
## Creating directories
WORKDIR /europa
COPY ./recreate-directory-structure-docker.sh /europa/
RUN chmod +x ./recreate-directory-structure-docker.sh
RUN ./recreate-directory-structure-docker.sh
WORKDIR /root/europa
## Docker build finished