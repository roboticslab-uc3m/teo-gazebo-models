FROM ubuntu:jammy AS build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        wget \
        unzip \
        ca-certificates \
        build-essential \
        cmake \
        libtinyxml-dev \
        libeigen3-dev \
        libgazebo-dev

ARG YARP_TAG=master

RUN wget -O ycm-cmake-modules.zip https://github.com/robotology/ycm-cmake-modules/archive/master.zip && \
    wget -O yarp.zip https://github.com/robotology/yarp/archive/$YARP_TAG.zip && \
    wget -O gazebo-yarp-plugins.zip https://github.com/robotology/gazebo-yarp-plugins/archive/master.zip && \
    wget -O teo-gazebo-models.zip https://github.com/roboticslab-uc3m/teo-gazebo-models/archive/master.zip

RUN unzip ycm-cmake-modules.zip && \
    unzip yarp.zip && \
    unzip gazebo-yarp-plugins.zip && \
    unzip teo-gazebo-models.zip

ARG CORES=1

RUN cmake -S ycm-cmake-modules-master -B ycm-cmake-modules-master/build \
        -DCMAKE_INSTALL_PREFIX:PATH=/install && \
    cmake --build ycm-cmake-modules-master/build --target install

RUN cmake -S yarp-$YARP_TAG -B yarp-$YARP_TAG/build \
        -DCMAKE_INSTALL_PREFIX:PATH=/install \
        -DSKIP_ACE:BOOL=ON && \
    cmake --build yarp-$YARP_TAG/build --target install -- -j$CORES

RUN cmake -S gazebo-yarp-plugins-master -B gazebo-yarp-plugins-master/build \
        -DCMAKE_INSTALL_PREFIX:PATH=/install && \
    cmake --build gazebo-yarp-plugins-master/build --target install -- -j$CORES

RUN cmake -S teo-gazebo-models-master -B teo-gazebo-models-master/build \
        -DCMAKE_INSTALL_PREFIX:PATH=/install && \
    cmake --build teo-gazebo-models-master/build --target install

FROM ubuntu:jammy
COPY --from=build /install /usr/local

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        libtinyxml2.6.2v5 \
        gazebo \
        gazebo-plugin-base && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

COPY gazebo_models.txt /
COPY gui.ini /root/.gazebo/

RUN mkdir -p ~/.gazebo/models && \
    wget -i gazebo_models.txt && \
    ls model.tar.gz* | xargs -n 1 sh -c 'tar xzvf "$@" -C ~/.gazebo/models/' dummy && \
    rm model.tar.gz*

RUN ldconfig && \
    ln -s /usr/local/share/gazebo /gazebo

VOLUME ["/root/.gazebo/models"]
VOLUME ["/root/.config/yarp/"]
VOLUME ["/gazebo"]

ENV GAZEBO_MODEL_PATH=/gazebo/models
ENV YARP_COLORED_OUTPUT=1

ENTRYPOINT ["/usr/bin/gazebo"]
WORKDIR /gazebo/worlds
