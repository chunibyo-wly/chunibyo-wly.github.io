---
typora-root-url: ..
title: data_utils
mathjax: true
date: 2020-02-05 22:05:54
tags:
categories:
	- cv
---
![Visualization example](/images/viz_example.png)

<!-- more -->

## h36m.zip

### camera.h5

1. 按照h36m的文件存储了4个相机的参数
   ![image-20200207161415102](/images/image-20200207161415102.png)
2. 参数规格与注释一致
   ![image-20200207165512487](/images/image-20200207165512487.png)

### 3D postion

1. 
   ![image-20200207170152897](/images/image-20200207170152897.png)
2. `read_3d_data`(, 16*3)

### 2D position

1. `create_2d_data`(, 16*2)
2. `read_2d_predictions`(, 16*2)

## load_data

### Example

```python
load_data(path.join("data", "h36m"), [1, 5], ["Directions"], 3)
```

![image-20200206092334897](/images/image-20200206092334897.png)

- **bpath**: String. Path where to load the data from
- **subjects**: List of integers. Subjects whose data will be loaded
- **actions**: List of strings. The actions to load
- **dim**: Integer={2,3}. Load 2 or 3-dimensional data

### Stdout

```
Reading subject 1, action Directions
data\h36m\S1\MyPoses\3D_positions\Directions*.h5
data\h36m\S1\MyPoses\3D_positions\Directions 1.h5
data\h36m\S1\MyPoses\3D_positions\Directions.h5
Reading subject 5, action Directions
data\h36m\S5\MyPoses\3D_positions\Directions*.h5
data\h36m\S5\MyPoses\3D_positions\Directions 1.h5
data\h36m\S5\MyPoses\3D_positions\Directions 2.h5
```

### Return

```json
{
    (1, 'Directions', 'Directions 1.h5'):np.array([[]]),
    (1, 'Directions', 'Directions.h5'):np.array([[]]),
    (5, 'Directions', 'Directions 1.h5'):np.array([[]]),
    (5, 'Directions', 'Directions 2.h5'):np.array([[]]),
}
```

### Else

1. 获取指定路径下的所有文件

   ```python
   fnames = glob.glob(dpath)
   ```

2. 解决`SittingDown`匹配到`Sitting`的情况

   ```python
   if action == "Sitting" and seqname.startswith("SittingDown"):
       continue
   ```

3. 文件读取成功的验证

   ```python
   if dim == 2:
       assert loaded_seqs == 8, "Expecting 8 sequences, found {0} instead".format(loaded_seqs)
       else:
           assert loaded_seqs == 2, "Expecting 2 sequences, found {0} instead".format(loaded_seqs)
   ```
	![image-20200206115526898](/images/image-20200206115526898.png)
	
4. **注意**
   这个`h36m.zip`的数据集没有`2D grout truth`, 也就是load_data的2D功能无法使用

## load_stacked_hourglass

### Example

```python
load_stacked_hourglass(path.join("data", "h36m"), [1], ["Directions"])
```

### Return

```json
{
    (1, 'Directions', 'Directions.54138969.h5-sh'):np.array([[]]),
    (1, 'Directions', 'Directions.55011271.h5-sh'):np.array([[]]),
    (1, 'Directions', 'Directions.58860488.h5-sh'):np.array([[]]),
    (1, 'Directions', 'Directions.60457274.h5-sh'):np.array([[]]),
    (1, 'Directions', 'Directions 1.54138969.h5-sh'):np.array([[]]),
    (1, 'Directions', 'Directions 1.55011271.h5-sh'):np.array([[]]),
    (1, 'Directions', 'Directions 1.58860488.h5-sh'):np.array([[]]),
    (1, 'Directions', 'Directions 1.60457274.h5-sh'):np.array([[]]),
}
```

### Else

1. StackHourglass与GroudTruth顺序对应

   ```python
   SH_TO_GT_PERM = np.array([SH_NAMES.index(h) for h in H36M_NAMES if h != '' and h in SH_NAMES])
   ```

   ![image-20200206121752737](/images/image-20200206121752737.png)

   

   
## normalize_data
### Else

1. Z-Score标准化

   ```python
   data_out[key] = np.divide((data[key] - mu), stddev)
   ```

   $$
   x_{new}=\frac{x-\mu}{\delta}
   $$
   
   ![img](/images/v2-ee0280ea470db277509e95efce1991f6_hd.jpg)

## project_to_cameras

`cameras.project_point_radial`的上层封装

## read_2d_predictions

`load_stacked_hourglass`的上层封装

1. 读取`Stacked Hourglass`
2. 划分`train_set`与`test_set`
   ![image-20200206234918973](/images/image-20200206234918973.png)
3. 并且分别归一化

### Example

```python
read_2d_predictions(["Directions"], r"data\h36m")
```

### Stdout

```
Reading subject 1, action Directions
data\h36m\S1\StackedHourglass\Directions*.h5
data\h36m\S1\StackedHourglass\Directions.54138969.h5
data\h36m\S1\StackedHourglass\Directions.55011271.h5
data\h36m\S1\StackedHourglass\Directions.58860488.h5
data\h36m\S1\StackedHourglass\Directions.60457274.h5
data\h36m\S1\StackedHourglass\Directions_1.54138969.h5
data\h36m\S1\StackedHourglass\Directions_1.55011271.h5
data\h36m\S1\StackedHourglass\Directions_1.58860488.h5
data\h36m\S1\StackedHourglass\Directions_1.60457274.h5
Reading subject 5, action Directions
data\h36m\S5\StackedHourglass\Directions*.h5
data\h36m\S5\StackedHourglass\Directions_1.54138969.h5
data\h36m\S5\StackedHourglass\Directions_1.55011271.h5
data\h36m\S5\StackedHourglass\Directions_1.58860488.h5
data\h36m\S5\StackedHourglass\Directions_1.60457274.h5
data\h36m\S5\StackedHourglass\Directions_2.54138969.h5
data\h36m\S5\StackedHourglass\Directions_2.55011271.h5
data\h36m\S5\StackedHourglass\Directions_2.58860488.h5
data\h36m\S5\StackedHourglass\Directions_2.60457274.h5
Reading subject 6, action Directions
data\h36m\S6\StackedHourglass\Directions*.h5
data\h36m\S6\StackedHourglass\Directions.54138969.h5
data\h36m\S6\StackedHourglass\Directions.55011271.h5
data\h36m\S6\StackedHourglass\Directions.58860488.h5
data\h36m\S6\StackedHourglass\Directions.60457274.h5
data\h36m\S6\StackedHourglass\Directions_1.54138969.h5
data\h36m\S6\StackedHourglass\Directions_1.55011271.h5
data\h36m\S6\StackedHourglass\Directions_1.58860488.h5
data\h36m\S6\StackedHourglass\Directions_1.60457274.h5
Reading subject 7, action Directions
data\h36m\S7\StackedHourglass\Directions*.h5
data\h36m\S7\StackedHourglass\Directions.54138969.h5
data\h36m\S7\StackedHourglass\Directions.55011271.h5
data\h36m\S7\StackedHourglass\Directions.58860488.h5
data\h36m\S7\StackedHourglass\Directions.60457274.h5
data\h36m\S7\StackedHourglass\Directions_1.54138969.h5
data\h36m\S7\StackedHourglass\Directions_1.55011271.h5
data\h36m\S7\StackedHourglass\Directions_1.58860488.h5
data\h36m\S7\StackedHourglass\Directions_1.60457274.h5
Reading subject 8, action Directions
data\h36m\S8\StackedHourglass\Directions*.h5
data\h36m\S8\StackedHourglass\Directions.54138969.h5
data\h36m\S8\StackedHourglass\Directions.55011271.h5
data\h36m\S8\StackedHourglass\Directions.58860488.h5
data\h36m\S8\StackedHourglass\Directions.60457274.h5
data\h36m\S8\StackedHourglass\Directions_1.54138969.h5
data\h36m\S8\StackedHourglass\Directions_1.55011271.h5
data\h36m\S8\StackedHourglass\Directions_1.58860488.h5
data\h36m\S8\StackedHourglass\Directions_1.60457274.h5
Reading subject 9, action Directions
data\h36m\S9\StackedHourglass\Directions*.h5
data\h36m\S9\StackedHourglass\Directions.54138969.h5
data\h36m\S9\StackedHourglass\Directions.55011271.h5
data\h36m\S9\StackedHourglass\Directions.58860488.h5
data\h36m\S9\StackedHourglass\Directions.60457274.h5
data\h36m\S9\StackedHourglass\Directions_1.54138969.h5
data\h36m\S9\StackedHourglass\Directions_1.55011271.h5
data\h36m\S9\StackedHourglass\Directions_1.58860488.h5
data\h36m\S9\StackedHourglass\Directions_1.60457274.h5
Reading subject 11, action Directions
data\h36m\S11\StackedHourglass\Directions*.h5
data\h36m\S11\StackedHourglass\Directions.55011271.h5
data\h36m\S11\StackedHourglass\Directions.58860488.h5
data\h36m\S11\StackedHourglass\Directions.60457274.h5
data\h36m\S11\StackedHourglass\Directions_1.54138969.h5
data\h36m\S11\StackedHourglass\Directions_1.55011271.h5
data\h36m\S11\StackedHourglass\Directions_1.58860488.h5
data\h36m\S11\StackedHourglass\Directions_1.60457274.h5
```

## create_2d_data

### Else

1. 读取`Ground Truth`
2. 投影到2D
3. 划分`train_set`与`test_set`
   ![image-20200206234918973](/images/image-20200206234918973.png)
4. 并且分别归一化(可以看作`2D Ground Truth`)

## Function

![function](/images/function.png)