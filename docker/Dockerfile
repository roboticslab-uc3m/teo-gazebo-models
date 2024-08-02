FROM ubuntu:22.04

ARG YARP_TAG=master
ARG CORES=1

COPY gazebo_models.txt /

RUN DEBIAN_FRONTEND=noninteractive \
    DEV_PACKAGES="wget unzip build-essential cmake libtinyxml-dev libeigen3-dev libgazebo-dev" && \
    apt-get update && \
    apt-get install -y libtinyxml2.6.2v5 gazebo $DEV_PACKAGES && \
    wget -O ycm-cmake-modules.zip https://github.com/robotology/ycm-cmake-modules/archive/master.zip && \
    wget -O yarp.zip https://github.com/robotology/yarp/archive/$YARP_TAG.zip && \
    wget -O gazebo-yarp-plugins.zip https://github.com/robotology/gazebo-yarp-plugins/archive/master.zip && \
    wget -O teo-gazebo-models.zip https://github.com/roboticslab-uc3m/teo-gazebo-models/archive/master.zip && \
    unzip ycm-cmake-modules.zip && \
    unzip yarp.zip && \
    unzip gazebo-yarp-plugins.zip && \
    unzip teo-gazebo-models.zip && \
    cmake -S ycm-cmake-modules-master -B ycm-cmake-modules-master/build && \
    cmake --build ycm-cmake-modules-master/build --target install && \
    cmake -S yarp-$YARP_TAG -B yarp-$YARP_TAG/build -DSKIP_ACE=ON && \
    cmake --build yarp-$YARP_TAG/build --target install -- -j$CORES && \
    cmake -S gazebo-yarp-plugins-master -B gazebo-yarp-plugins-master/build && \
    cmake --build gazebo-yarp-plugins-master/build --target install -- -j$CORES && \
    cmake -S teo-gazebo-models-master -B teo-gazebo-models-master/build && \
    cmake --build teo-gazebo-models-master/build --target install && \
    rm ycm-cmake-modules.zip yarp.zip gazebo-yarp-plugins.zip teo-gazebo-models.zip && \
    rm -rf ycm-cmake-modules-master yarp-$YARP_TAG gazebo-yarp-plugins-master teo-gazebo-models-master && \
    mkdir -p ~/.gazebo/models && \
    wget -i gazebo_models.txt && \
    ls model.tar.gz* | xargs -n 1 sh -c 'tar xzvf "$@" -C ~/.gazebo/models/' dummy && \
    rm model.tar.gz* && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y $DEV_PACKAGES && \
    apt-get autopurge -y && \
    apt-get clean

VOLUME ["/root/.gazebo/models"]
VOLUME ["/root/.config/yarp/"]

ENV GAZEBO_MODEL_PATH=/usr/local/share/gazebo/models
ENV YARP_COLORED_OUTPUT=1

ENTRYPOINT ["/usr/bin/gazebo"]
WORKDIR /usr/local/share/gazebo/worlds
