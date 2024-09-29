#!/bin/bash

# Check if a path argument is provided, otherwise use the default path
if [ -n "$1" ]; then
    cd "$1" || { echo "Invalid directory path"; exit 1; }
else
    cd ~/sept_autoware_dir/autoware || { echo "Default directory does not exist"; exit 1; }
fi

# Set environment variables for ROS
export ROS_LOCALHOST_ONLY=2  # Allow communication across the same network
export ROS_DOMAIN_ID=2       # Ensure nodes are in the same domain
export DISPLAY=:1            # Set correct display

# Source the ROS2 workspace
source install/setup.bash

# Launch the ROS2 simulation
ros2 launch autoware_launch planning_simulator.launch.xml \
    map_path:=$HOME/autoware_map/sample-map-planning \
    vehicle_model:=sample_vehicle \
    sensor_model:=sample_sensor_kit