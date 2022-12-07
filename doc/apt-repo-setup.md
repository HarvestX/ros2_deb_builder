# How to access the apt repository

## Add apt source

Following instructions add your localhost apt repository to your hostmachine. IP address or the name of gpg key might be different from yours, so please fix them if necessary.

1. Update the `apt` package index and install packages.

```sh
sudo apt-get update
sudo apt-get install curl gnupg
```

2. Import the public key from the apt repository

```sh
sudo mkdir -p /etc/apt/keyrings
curl -fsSL http://localhost/gpg/sample.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/sample.gpg
```

3. Use the following command to set up the repository (currently only `amd64` of Ubuntu 20.04 is supported)

```sh
echo \
  "deb [arch=amd64 signed-by=/etc/apt/keyrings/sample.gpg] http://localhost/ stable main" \
  | sudo tee /etc/apt/sources.list.d/sample.list > /dev/null
```

4. Update the `apt` package index

```sh
sudo apt-get update
```

If you don't receive any errors, you can now install any packages from apt repository.

```sh
sudo apt-get install ros-galactic-h6x-internship-gazebo
```

## Add rosdep source

The following command adds rosdep source so that rosdep can resolve rosdep keys of this repository's packages.

```sh
echo "yaml http://localhost/rosdep/my_rosdep.yaml" \
  | sudo tee /etc/ros/rosdep/sources.list.d/50-my-packages.list > /dev/null
rosdep update
```
