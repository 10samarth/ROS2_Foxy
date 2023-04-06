# Use Ubuntu 20.04 as base image
FROM ubuntu:20.04

# Set environment variables
ENV ROS_DISTRO foxy
ENV DEBIAN_FRONTEND noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    sudo \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Set up ROS2 sources and keys
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# Install ROS2 dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libopencv-dev \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    ros-foxy-desktop \
    ros-foxy-ros-base \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init && rosdep update

# Create a new workspace
RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws

# # Clone an example ROS2 package

# RUN cd src && \
#     git clone https://github.com/ros2/examples.git && \
#     cd ..

# # Install dependencies of the example package
# RUN apt-get update && \
#     rosdep install --from-paths src --ignore-src -r -y && \
#     rm -rf /var/lib/apt/lists/*

# # Build the workspace
# RUN colcon build

# Set up the entry point
CMD ["bash"]
