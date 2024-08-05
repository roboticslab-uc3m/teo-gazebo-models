3D Gazebo models for TEO robot. If you are looking for the source code of the robot itself, visit the [teo-main](https://github.com/roboticslab-uc3m/teo-main) repository.

## Installation

Installation instructions for installing from source can be found [here](doc/teo-gazebo-models-install.md).

## Usage

We recomment to add this line at the end of your `~/.bashrc` (Linux) so that Gazebo can discover and load the models with no further input from terminal (using standard installation path):

```bash
export GAZEBO_MODEL_PATH=/usr/local/share/gazebo/models:$GAZEBO_MODEL_PATH
```

Launch the robot standing on its own feet:

```
gazebo path/to/worlds/teo.world
```

Launch the robot floating slightly above ground with fixed root links:

```
gazebo path/to/worlds/teo_fixed.world
```

## Docker

The following Docker images are available in the [ghcr.io container registry](https://github.com/roboticslab-uc3m/teo-gazebo-models/pkgs/container/teo-gazebo-models):

- `docker pull ghcr.io/roboticslab-uc3m/teo-gazebo-models:latest`: Gazebo 11 + YARP + plugins
- `docker pull ghcr.io/roboticslab-uc3m/teo-gazebo-models:ros2`: Gazebo 11 + YARP + ROS Humble + plugins

TEO Gazebo models are already preinstalled.

### Usage

The image is configured to use the `gazebo` executable as entry point and use the `/usr/local/share/gazebo/worlds` path as the working directory.

First, make sure you launched the YARP server (`yarp server --write`) and gave access to the X server (`sudo xhost +`). Then, issue the following command anywhere on the preinstalled model you wish to use, e.g. `teo_fixed.world`:

```bash
docker run --rm --privileged \
           -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
           -v $HOME/.config/yarp:/root/.config/yarp:ro \
           -e DISPLAY \
           ghcr.io/roboticslab-uc3m/teo-gazebo-models:latest teo_fixed.world
```

Alternatively, appending `-v $XAUTHORITY:/root/.Xauthority:ro` to the list of options would avoid the need of `sudo xhost +`. In .bashrc, add the following line:

`export XAUTHORITY=$(xauth info | grep "Authority file" | awk '{ print $3 }')`

#### Developing

You might want to clone this repo and load the models you are currently working on instead of the preinstalled ones. A volume mounting point can be added on the current working directory (make sure it is the root directory of this repo, not `models/` nor `worlds/`):

```bash
docker run --rm --privileged \
           -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
           -v $HOME/.config/yarp:/root/.config/yarp:ro \
           -v $PWD:/gazebo:ro \
           -e DISPLAY \
           ghcr.io/roboticslab-uc3m/teo-gazebo-models:latest teo_fixed.world
```

#### .bashrc

For ease of use, the following Bash aliases can be added to .bashrc:

```bash
XAUTHORITY=$(xauth info | grep "Authority file" | awk '{ print $3 }')
alias gazebo='docker run --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $XAUTHORITY:/root/.Xauthority:ro -v $HOME/.config/yarp:/root/.config/yarp:ro -e DISPLAY ghcr.io/roboticslab-uc3m/teo-gazebo-models:latest'
alias gazebo-ros='docker run --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $XAUTHORITY:/root/.Xauthority:ro -v $HOME/.config/yarp:/root/.config/yarp:ro -e DISPLAY ghcr.io/roboticslab-uc3m/teo-gazebo-models:ros2'
alias gazebo-dev='docker run --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $XAUTHORITY:/root/.Xauthority:ro -v $HOME/.config/yarp:/root/.config/yarp:ro -v $PWD:/gazebo:ro -e DISPLAY ghcr.io/roboticslab-uc3m/teo-gazebo-models:latest'
alias gazebo-ros-dev='docker run --rm --privileged -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $XAUTHORITY:/root/.Xauthority:ro -v $HOME/.config/yarp:/root/.config/yarp:ro -v $PWD:/gazebo:ro -e DISPLAY ghcr.io/roboticslab-uc3m/teo-gazebo-models:ros2'
```

### Building

The following build args are available:

- `YARP_TAG`: YARP tag/branch/commit to compile against (default: `master`)
- `CORES`: number of cores passed to the compiler (default: `1`)

Note that `YARP_TAG=yarp-3.9` was reported to cause issues ([#10](https://github.com/roboticslab-uc3m/teo-gazebo-models/issues/10#issuecomment-2267623679)).

Example:

```bash
cd /path/to/teo-gazebo-models/docker
docker build -t ghcr.io/roboticslab-uc3m/teo-gazebo-models:latest --build-arg CORES=18 --build-arg YARP_TAG=master --file Dockerfile .
```

It is advised to use the GitHub Action `docker.yml` via manual dispatch (click on ["Run workflow"](https://github.com/roboticslab-uc3m/teo-gazebo-models/actions/workflows/docker.yml)).

## Contributing

#### Posting Issues

1. Read [CONTRIBUTING.md](CONTRIBUTING.md)
2. [Post an issue / Feature request / Specific documentation request](https://github.com/roboticslab-uc3m/teo-gazebo-models/issues)

#### Fork & Pull Request

1. [Fork the repository](https://github.com/roboticslab-uc3m/teo-gazebo-models/fork)
2. Create your feature branch (`git checkout -b my-new-feature`) off the `master` branch, following the [Forking Git workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow)
3. Commit your changes
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Status

[![Issues](https://img.shields.io/github/issues/roboticslab-uc3m/teo-gazebo-models.svg?label=Issues)](https://github.com/roboticslab-uc3m/teo-gazebo-models/issues)
