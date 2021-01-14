---
typora-root-url: ..
title: Camera
mathjax: true
date: 2020-02-02 22:03:49
tags:
categories:
	- cv
---
![image-20210114193109534](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193109534.png)

<!-- more -->

相机将三维世界中的坐标点（单位为米）映射到二维图像平面（单位为像素）的过程 能够用一个几何模型进行描述。这个模型有很多种，其中最简单的称为**针孔模型**。

# 单目相机

## 针孔模型

![image-20210114193141067](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193141067.png)
$$
\frac{Z}{f}=\frac{X}{X'}=\frac{Y}{Y'}
$$

$$
X'=f\frac{X}{Z} \\
Y'=f\frac{Y}{Z}
$$

![image-20210114193213213](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193213213.png)

- $f$: 焦距
- $X,Y$: 三维空间相对于光心$O$的坐标(相机坐标系)
- $X',Y'$: 投影到相对于$O'$的坐标

## 像素坐标系

原点 o′ 位于图像的左上角，u 轴向右与 x 轴平行，v轴向下与 y 轴平行。像素坐标系与成像平面之间，相差了一个**缩放**和一个**原点的平移**。

设像素坐标在 u 轴上缩放了 α 倍，在 v 上缩放了 β 倍。同时，原点平移了 $[c_{x},c_{y}]^{T}$
$$
\begin{cases}
u=\alpha X'+ c_{x} \\
v=\beta y' + c_{y}
\end{cases}
$$

$$
\begin{cases}
u = f_{x} \frac{X}{Z} + c_{x} \\
v = f_{y} \frac{Y}{Z} + c_{y}
\end{cases}
$$

$$
Z
\begin{pmatrix}
u \\
v \\
1
\end{pmatrix}

=

\begin{pmatrix}
f_{x} & 0     & c_{x} \\
0     & f_{y} & c_{y} \\
0     & 0     & 1
\end{pmatrix}
\begin{pmatrix}
X \\
Y \\
Z
\end{pmatrix}

=

KP
$$

- $K$: 相机内参数矩阵
- $P$: 相机坐标系下的点的坐标

## 畸变

- **径向畸变**(穿过图像中心和光轴有交点的直线还能保持形状不变)

  1. ![image-20210114193241973](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193241973.png)
  2. ![image-20210114193254789](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193254789.png)

- **切向畸变**

  ![image-20210114193324591](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193324591.png)

## 总结

![image-20210114193400782](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193400782.png)

## Camera库

### project_point_radial

1. 世界坐标系转换到相机坐标系
```python
N = P.shape[0]
X = R.dot(P.T - T)  # rotate and translate
```
$$
P_{c}=RP_{w}+t
$$

2. 归一化
```python
XX = X[:2, :] / X[2, :]  # 2x16
```

$$
P_{c}=[\frac{X}{Z}, \frac{Y}{Z}, 1]^T
$$

3. 调整过畸变的相机坐标转像素坐标(物理成像面)
```python
Proj = (f * XXX) + c  # 2x16
Proj = Proj.T
```

4. 相机坐标的深度
```python
D = X[2, ]
```

### load_camera_params

1. $R$: 相机旋转矩阵
2. $T$: 相机平移矩阵
3. $f$: 相机焦距长度
4. $c$: 相机中心
5. $k$: 相机径向变形系数
6. $p$: 相机切向变形系数

# 双目相机

## 基础模型

首先这个模型是基于针孔模型的

![image-20210114193412461](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114193412461.png)

- $u_{L}, u_{R}$: 像素坐标
- $O_{L}, O_{R}$: 光心
- $b$: 基线
- $z$: 需要求的深度

$$
\frac{z-f}{z} = \frac{b-u_{L}+u_{R}}{b}
$$

$$
z = \frac{fb}{d}, d=u_{L}-u{R}
$$

$d$为左右图的横坐标之差，称为视差