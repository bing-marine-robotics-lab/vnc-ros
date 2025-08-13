# ROS on Mac/Windows/Ubuntu

Before following the next two steps, install Docker ([installation instructions for Mac](https://docs.docker.com/docker-for-mac/install/) or [for Windows](https://docs.docker.com/docker-for-windows/install/#system-requirements-for-wsl-2-backend) or [for Ubuntu](https://docs.docker.com/engine/install/ubuntu/)).

## 1. Setup
Open a new terminal in the Mac or PowerShell in Windows.
1. Once the terminal is open, clone this repository with the command `git clone https://github.com/bing-marine-robotics-lab/vnc-ros.git`
2. Enter in the cloned repository folder, `cd vnc-ros`
3. Create a folder called `workspace` with the command `mkdir workspace`
4. Run `docker compose up --build`

(`ros.env` contains environment variables for ROS that can be modified before running the command in step 3.)

## 2. Running a the container
Once the other terminal shows the following type of messages and remains running without errors

     ⠿ Container vnc-ros-ros-1    Cr...                           0.0s
     ⠿ Container vnc-ros-novnc-1  Recreated                       0.1s
    Attaching to vnc-ros-novnc-1, vnc-ros-ros-1
    ... (comment: more messages, with the latest being in the current version of Docker)

    vnc-ros-novnc-1  | 2023-03-29 19:45:10,919 INFO success: xterm entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)

(Note that there might be some slight variations of outputs, as long as the terminal is "occupied" by that command, you can go to the next step)

To see whether it was successful, in running the simulation
1. Open your browser to `localhost:8080/vnc.html` and click connect.

Open another terminal:
1. Run `docker compose exec ros bash` (`docker compose up` has to be running)
2. Run `source /opt/ros/jazzy/setup.bash`

## 3. To terminate

In the terminal open for step 3., press ctrl+d (or type exit) to exit the Docker container.

Afterwards, in the terminal open for step 1., press ctrl+c. Once terminated, you should see the following messages

    Stopping mac-ros_ros_1   ... done
    Stopping mac-ros_novnc_1 ... done

At this point, both terminals can be closed if you wish.

Note: sometimes it fails to stop. For now, recommend to restart your system.

## Editing your workspace
The `workspace` folder created on your machine by `docker compose` is where you can write and edit your packages. That folder maps to `~/catkin_ws` on the Docker container and is shared between the host machine and the Docker container. 

## Installing other packages
Edit the `Dockerfile` line that installs packages and rebuild the container using `docker compose build`.
