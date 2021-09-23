# APM问题总结

##### 1.mavros话题：

**setpoint_raw/attitude** 使用 **NED** 作为坐标系，而 setpoint_attitude/attitude 主题使用 [ENU](https://discuss.px4.io/t/mavros-setpoint-raw-attitude/9016)

##### 2.setpoint_raw/attitude可以设置姿态和推力（0，1）， setpoint_attitude/attitude可以设置姿态和位置；推力设置为setpoint_attitude/thrust

##### 3.solidworks导出的模型为黑色的

只需要将导出后的sdf文件中的material标签中的以下代码注释掉（即文中已经注释掉的部分）：

```xml
          <material>
<!--            <shader type='pixel'>-->
<!--              <normal_map>__default__</normal_map>-->
<!--            </shader>-->
            <script>
              <name>Gazebo/Red</name>
              <uri>file://media/materials/scripts/gazebo.material</uri>
<!--              <name>ModelPreview_1::base_link::base_link_visual_MATERIAL_</name>-->
<!--              <uri>__default__</uri>-->
            </script>
<!--            <ambient>0 0 0 1</ambient>-->
<!--            <diffuse>0 0 0 1</diffuse>-->
<!--            <specular>0 0 0 1</specular>-->
<!--            <emissive>0 0 0 1</emissive>-->
          </material>
<!--          <transparency>0</transparency>-->
<!--          <cast_shadows>1</cast_shadows>-->
```



##### 4.模型的转动惯量设置挺重要的

这是一个转动惯量等物理量的在线计算[网站](https://edu.yanfabu.com/tools/show/1365/112/)

##### 5.gazebo中模型的摩擦：

The sdf documentation says it should be in range [0..1]. we can see that anything over 1.0 is treated as 1.0 (infinite friction).

##### 6.gazebo[仿真频率问题](http://gazebosim.org/tutorials?tut=physics_params&cat=physics)：设置real_time_update_rate

```xml
    <physics type='ode'>
 	 <max_step_size>0.01</max_step_size>
 	 <real_time_factor>1</real_time_factor>
  	<real_time_update_rate>100</real_time_update_rate>
 	 <gravity>0 0 -9.81</gravity>
 	 <!-- <gravity>0 0 0</gravity> -->
    </physics>
```

> <max_step_size>
> 这个参数指定了每个物理更新步骤的持续时间（秒）。
> <real_time_update_rate>
> 该参数以赫兹为单位指定每秒尝试的物理更新次数。如果这个数字设为0，它就会尽可能快地运行。注意，<real_time_update_rate>和<max_step_size>的乘积表示 the target <real_time_factor>，即模拟时间与实时的比率。

##### 7.gazebo[关闭仿真界面](https://www.dazhuanlan.com/2019/12/09/5dedf63cd7c52/)等问题

##### 8.[Ardupilot飞控姿态角与姿态角速度控制过程分析(超长篇)](https://blog.csdn.net/lixiaoweimashixiao/article/details/80934863)

##### 9.如何修改遥控器输入：

```bash
横滚命令： rc 1  1200
俯仰命令： rc 2  1200
油门命令： rc 3   1200
偏航命令： rc 4    1600
```

##### 10.模式切换不成功，是因为没有给定油门值，所以一切换就会掉下来。

```
arm throttle
rc 3 1800
```

1800 为油门值，1500油门值中立。



##### 11.术语

**FCS**(Flight Control System)飞行控制系统：与FCU相区别，FCS是包含FCU以及其它硬件、软件、算法的系统集合。

**FCU**(Flight Control Unit)飞行控制单元：接收并处理从接收机发来的遥控器信号;接收并处理传感器发来的反馈信号;通过相应算法得出机体信息;通过相应算法结合机体信息得出控制输出量;将控制输出量给出到执行器部分的软件与硬件的结合。

##### 12.HIL Control

硬件在环仿真(Hardware-in-the-loop simulation, *HiL*或*HIL*) 

##### 13.[Ardupilot添加一个新模式全攻略](https://blog.csdn.net/yinxian5224/article/details/97497969)，以Copter为例

##### 14./mavros/actuator_control 没有订阅话题

将apm.launch中的blacklist注释掉

##### 15. 将模型固定在地面

在相应的模型里，比如logger0里面，加入：

```xml
<joint name='fixing_to_ground' type='fixed'>
    <parent>world</parent>
    <child>logger0_chassis</child>
    <pose frame=''>0 0 -0.49 0 -0 0</pose>
</joint>
```

或者，将对应模型的`<static>`设置为true（1），就不会移动了，如果希望模型可移动，请将标签设置为 false（0）。

```xml
<static>1</static>
```

##### 16.使用pwm波控制每个电机

详情请看脚本文件夹：bash

##### 17.插件订阅的问题

注意subscriber的缓存队列的大小，会影响回调结果，这与ROS的回调机制相关，ROS在发生回调是会将所有队列中的消息分别送往回调函数中，因此**如果队列未被及时更新，可能出现多次重复响应，因此建议设置为1**，或者慎重考虑下运行频率相关。

##### 18.ros掉包问题

当节点初始化放在**话题注册**前面时，会出现掉包（前面一两个包）的情况.因此将节点初始化放在**话题注册**后面。

##### 19.gazebo sdf模型下载

[模型下载](https://3dwarehouse.sketchup.com/search/?q=cone)

##### 20.实时画图工具

[PlotJuggler](https://github.com/facontidavide/PlotJuggler)

```bash
  rosrun plotjuggler plotjuggler
```

##### 21.RuntimeError: Variable -= value not supported问题

如果报-=不支持的话，那就不要写成-=，改成x=x-这种形式，如：

```python
x -= 0.01 * grads
---
===>
x = x- 0.01*grads

```

+=同理。

当然也可以考虑assign_sub(减去一个数)or assign_add（加上一个数）方法。

如变成：

```
x.assign_sub(0.01*grads)
```

