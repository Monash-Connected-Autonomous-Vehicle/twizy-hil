#!/bin/bash

# Check if a path argument is provided, otherwise use the default path
if [ -n "$1" ]; then
    cd "$1" || { echo "Invalid directory path"; exit 1; }
else
# ~/test_sd/ack_ws's src folder contains the following packages:
# SD-VehicleInterface (ackermann branch): https://github.com/Monash-Connected-Autonomous-Vehicle/SD-VehicleInterface/tree/ackermann
# autoware_msgs: https://github.com/autowarefoundation/autoware_msgs
    cd ~/test_sd/ack_ws || { echo "Default directory does not exist"; exit 1; }
fi

# Load the CAN module and configure the CAN interface
sudo modprobe peak_usb
sudo ip link set down can0 && sudo ip link set can0 up type can bitrate 500000

# Set environment variables for ROS
export ROS_LOCALHOST_ONLY=2  # Allow communication across the same network
export ROS_DOMAIN_ID=2       # Ensure nodes are in the same domain

# Source the ROS2 workspace
source install/setup.bash

# Launch the ROS2 application
ros2 launch sd_vehicle_interface sd_vehicle_interface.launch.xml \
    sd_vehicle:=twizy sd_speed_source:=vehicle_can_speed sd_simulation_mode:=false