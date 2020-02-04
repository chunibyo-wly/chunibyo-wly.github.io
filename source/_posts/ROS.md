---
typora-root-url: ..
title: ROS
mathjax: true
date: 2020-01-24 16:42:49
tags:
	- slam
categories:
	- cv
	- slam
---
![](/images/ROS_cat.png)
<!-- more -->
## ch9 工作空间与功能包

- workspace
  - src
  - build
  - devel
  - install

```bash
mkdir -p ros/src
cd ros/
catkin_init_workspace src/
catkin_make
source devel/setup.bash 
```

## ch10 Publisher

```cpp
/**
 * 该例程将发布turtle1/cmd_vel话题，消息类型geometry_msgs::Twist
 */

#include <geometry_msgs/Twist.h>
#include <ros/ros.h>

int main(int argc, char** argv)
{
    // ROS节点初始化
    ros::init(argc, argv, "velocity_publisher");

    // 创建节点句柄
    ros::NodeHandle n;

    // 创建一个Publisher，发布名为/turtle1/cmd_vel的topic，消息类型为geometry_msgs::Twist，队列长度10
    ros::Publisher turtle_vel_pub = n.advertise< geometry_msgs::Twist >("/turtle1/cmd_vel", 10);

    // 设置循环的频率
    ros::Rate loop_rate(10);

    int count = 0;
    while (ros::ok()) {
        // 初始化geometry_msgs::Twist类型的消息
        geometry_msgs::Twist vel_msg;
        vel_msg.linear.x = 0.5;
        vel_msg.angular.z = 0.2;

        // 发布消息
        turtle_vel_pub.publish(vel_msg);
        ROS_INFO("Publsh turtle velocity command[%0.2f m/s, %0.2f rad/s]",
            vel_msg.linear.x, vel_msg.angular.z);

        // 按照循环频率延时
        loop_rate.sleep();
    }

    return 0;
}
```



## ch11 Subscriber

```cpp
/**
 * 该例程将订阅/turtle1/pose话题，消息类型turtlesim::Pose
 */

#include "turtlesim/Pose.h"
#include <ros/ros.h>

// 接收到订阅的消息后，会进入消息回调函数
void poseCallback(const turtlesim::Pose::ConstPtr& msg)
{
    // 将接收到的消息打印出来
    ROS_INFO("Turtle pose: x:%0.6f, y:%0.6f", msg->x, msg->y);
}

int main(int argc, char** argv)
{
    // 初始化ROS节点
    ros::init(argc, argv, "pose_subscriber");

    // 创建节点句柄
    ros::NodeHandle n;

    // 创建一个Subscriber，订阅名为/turtle1/pose的topic，注册回调函数poseCallback
    ros::Subscriber pose_sub = n.subscribe("/turtle1/pose", 10, &poseCallback);

    // 循环等待回调函数
    ros::spin();

    return 0;
}
```

## ch12 自定义话题消息

```
string name
uint8 sex
uint8 age

uint8 unknown = 0
uint8 male = 1
uint8 female = 2
```

> 上半部分理解为一个类的成员变量
>
> 下本部分理解为宏定义