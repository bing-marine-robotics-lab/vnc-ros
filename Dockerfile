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


RUN mkdir -p /root/research
WORKDIR /root/research
RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash"
# Make a folder for all the event camera (dv camera) library packages
RUN mkdir dv-libs
WORKDIR /root/research/dv-libs
# Install libcaer
#	link: https://gitlab.com/inivation/dv/libcaer
RUN git clone https://gitlab.com/inivation/dv/libcaer.git
WORKDIR /root/research/dv-libs/libcaer
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr .
RUN make
RUN sudo make install
WORKDIR /root/research/dv-libs
# Now install dv-processing
#	link: https://gitlab.com/inivation/dv/dv-processing
#	It is OKAY that "make test" doesn't completely pass!!!
RUN git clone https://gitlab.com/inivation/dv/dv-processing.git --branch 1.7.9
WORKDIR /root/research/dv-libs/dv-processing
RUN mkdir build
WORKDIR /root/research/dv-libs/dv-processing/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr ..
RUN make -j4 -s
# RUN make test
RUN sudo make install
WORKDIR /root/research/dv-libs
# Now install dv-runtime
#	link: https://gitlab.com/inivation/dv/dv-runtime
RUN git clone https://gitlab.com/inivation/dv/dv-runtime.git --branch 1.6.2
WORKDIR /root/research/dv-libs/dv-runtime
RUN mkdir build
WORKDIR /root/research/dv-libs/dv-runtime/build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr ..
RUN make -j4 -s
RUN sudo make install
WORKDIR /root/research
# Now make a workspace for the ROS2 package for event camera
RUN mkdir -p inivation_ws/src
WORKDIR /root/research/inivation_ws/src

# Clone and build dv-ros2
#	link: https://github.com/Telios/dv-ros2
RUN git clone https://github.com/Telios/dv-ros2.git
WORKDIR /research/inivation_ws
RUN colcon build
# Update ~/.bashrc
RUN echo "source /root/research/inivation_ws/install/setup.bash" >> /root/.bashrc

RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src
RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash"
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.sh" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
RUN echo "defshell -bash" >> ~/.screenrc
# WORKDIR /root/catkin_ws/src
