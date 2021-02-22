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
