#!/bin/bash
set -e

# setup ros2 environment
source /opt/ros/humble/setup.bash --
source /ros2_interfaces_ws/install/setup.bash --
exec "$@"
