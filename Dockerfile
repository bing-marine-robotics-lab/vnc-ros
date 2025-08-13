FROM osrf/ros:jazzy-desktop

RUN apt-get -y update && apt-get install -y \
    curl

RUN apt-get -y update && apt-get install -y \
    iputils-ping \
    net-tools \
    wget \
    screen \
    git \
    nano \
    vim \
    htop \
    python3-pip \
    ros-${ROS_DISTRO}-mavros \
    ros-${ROS_DISTRO}-mavros-extras \
    ros-${ROS_DISTRO}-mavros-msgs \
    ros-${ROS_DISTRO}-image-transport-plugins \
    ros-dev-tools

RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash"
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.sh" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
RUN echo "defshell -bash" >> ~/.screenrc
# WORKDIR /root/catkin_ws/src
