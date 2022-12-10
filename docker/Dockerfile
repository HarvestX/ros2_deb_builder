FROM nvidia/cuda:11.5.2-cudnn8-devel-ubuntu20.04

ARG USERNAME=ros2-deb-builder
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# install build tools
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Etc/UTC

RUN apt-get update \
 && apt-get install -y apt-utils locales tzdata ssh dh-make dh-python \
 && apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" keyboard-configuration \
 && locale-gen en_US en_US.UTF-8 \
 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# install ros galactic
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu focal main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null \
 && apt-get update \
 && apt-get install -y ros-galactic-ros-base ros-dev-tools \
 && apt-get install -y python3-bloom python3-rosdep fakeroot

# create user
RUN groupadd --gid $USER_GID $USERNAME \
 && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
 && apt-get update \
 && apt-get install -y apt-utils sudo \
 && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME

# setup ros galactic
RUN . /opt/ros/galactic/setup.sh \
 && sudo rosdep init \
 && rosdep update --rosdistro galactic

# set env
ENV WS_GALACTIC /home/$USERNAME/ros2_deb_builder/ws_galactic
ENV REPOS_DIR /home/$USERNAME/ros2_deb_builder/repos
ENV SCRIPT_DIR /home/$USERNAME/ros2_deb_builder/script
ENV EXT_DIR /home/$USERNAME/ros2_deb_builder/external

CMD [ "/bin/bash", "-c", "$SCRIPT_DIR/run-all.bash" ]
