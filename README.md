# ROS2 Debian Package Builder

Build debian package from ROS2 package, and create apt repository for distribution.

## Environment

- Docker
- ROS2 Galactic

## Build Docker Image

Run the following commands.

```sh
$ cd docker/
$ docker build --build-arg USERNAME=$(whoami) --build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g) . -t ros2-deb-builder:galactic
```

## Prepare for Building

### GPG Keys

Please create a GPG key pair and put public key in `repos/gpg` and private key in `script/key`. Sample tool is stored in [here](./tools/create-gpg-key.bash). This process is required to create apt repository.

### List of repository

This build tool uses vcs to pull repositories, and the target file is `ws_galactic/src.repos`. Please fill it before proceeding. If you add private repositories, please make sure you have the proper ssh key in your host machine (`~/.ssh/`). Docker container tries to mount this directory to pull private repositories.

## Run Docker Container

Run the following commands.

```sh
$ cd {path_to_ros2_deb_builder}
$ docker run -it \
  -v /home/$(whoami)/.ssh:/home/$(whoami)/.ssh \
  -v `pwd`:/home/$(whoami)/ros2_deb_builder ros2-deb-builder:galactic
```

### Run apt Repository

Since the previous steps have already created apt repository, all you need to do is just run http server. One of the simple ways is to use nginx docker container.

```sh
$ cd {path_to_ros2_deb_builder}
$ docker run -d --rm -v ./repos:/usr/share/nginx/html:ro -p 80:80 nginx
```

## Access apt repository

You can now use <http://localhost/> as the apt repository. If it is the first time for your machine to access, [follow this instruction](./doc/apt-repo-setup.md) to setup the apt repository.
