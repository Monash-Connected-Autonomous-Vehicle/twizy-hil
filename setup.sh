mkdir -p ~/basic_ua_ctrl_ws/src/
cd ~/basic_ua_ctrl_ws/src/
git clone https://github.com/Monash-Connected-Autonomous-Vehicle/SD-VehicleInterface.git
git clone https://github.com/autowarefoundation/autoware_msgs.git
git clone https://github.com/Monash-Connected-Autonomous-Vehicle/autoware-dummy-publisher.git
cd ..
source /opt/ros/humble/setup.bash
sudo apt update && sudo apt upgrade
sudo rosdep init
rosdep update
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release