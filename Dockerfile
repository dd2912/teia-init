FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
 cmake \ 
 libopenimageio-dev \
 git \
 wget \
 zip \
 g++ \
 libgoogle-glog-dev \
 libgflags-dev \
 libatlas-base-dev \
 libceres-dev \
 libsuitesparse-dev \
 librocksdb-dev \
 rapidjson-dev \
 libjpeg-dev \ 
 freeglut3-dev \
 x11vnc \
 xvfb \
 vim
 
 
WORKDIR /opt
RUN wget https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.zip && unzip eigen-3.3.9.zip 
WORKDIR /opt/eigen-3.3.9/
RUN mkdir -p build && cd build && cmake .. && make -j3 && make install

WORKDIR /opt
RUN git clone https://github.com/google/glog.git
WORKDIR /opt/glog
RUN git checkout v0.4.0
RUN mkdir -p build && cd build && cmake .. && make -j3 && make install


WORKDIR /opt
RUN git clone https://github.com/ceres-solver/ceres-solver.git
WORKDIR /opt/ceres-solver/
RUN git checkout 1.14.0
RUN mkdir -p ceres-bin && cd ceres-bin && cmake .. && make -j3  && make install

WORKDIR /opt
RUN  git clone https://github.com/dd2912/TheiaSfM.git
WORKDIR /opt/TheiaSfM/
RUN mkdir /opt/TheiaSfM/build
WORKDIR /opt/TheiaSfM/build
RUN cmake .. && make -j4 && make install

WORKDIR /opt/TheiaSfM/build/applications/
RUN make && make install
ENV  PATH /opt/TheiaSfM/build/bin/:$PATH

CMD /bin/bash
