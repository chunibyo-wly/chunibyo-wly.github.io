---
typora-root-url: ..
title: cdflib
mathjax: true
date: 2020-02-12 15:03:42
tags:
categories:
	- cv

---

![image-20200212154935509](/images/image-20200212154935509.png)

<!-- more -->

https://pypi.org/project/cdflib/

1. 创建CDF class

   ```python
   import cdflib
   
   cdf_file = cdflib.CDF('/path/to/cdf_file.cdf')
   ```

2. cdf_info()
   返回CDF information

   ```json
   {
     'CDF': WindowsPath('data/S6/MyPoseFeatures/D2_Positions/Directions 1.54138969.cdf'),
     'Version': '3.3.0',
     'Encoding': 6,
     'Majority': 'Column_major',
     'rVariables': [
       
     ],
     'zVariables': [
       'Pose'
     ],
     'Attributes': [
       
     ],
     'Copyright': '\nCommon Data Format (CDF)\n(C) Copyright 1990-2009 NASA/GSFC\nSpace Physics Data Facility\nNASA/Goddard Space Flight Center\nGreenbelt, Maryland 20771 USA\n(Internet -- CDFSUPPORT@LISTSERV.GSFC.NASA.GOV)\n',
     'Checksum': False,
     'Num_rdim': 0,
     'rDim_sizes': [
       
     ],
     'Compressed': False,
     'LeapSecondUpdated': -1
   }
   ```

   

3. varinq(variable)
   返回variable的基本信息

   ```json
   {
     'Variable': 'Pose',
     'Num': 0,
     'Var_Type': 'zVariable',
     'Data_Type': 44,
     'Data_Type_Description': 'CDF_FLOAT',
     'Num_Elements': 1,
     'Num_Dims': 2,
     'Dim_Sizes': [
       2843,
       64
     ],
     'Sparse': 'No_sparse',
     'Last_Rec': 0,
     'Rec_Vary': True,
     'Dim_Vary': [
       -1,
       -1
     ],
     'Compress': 0,
     'Block_Factor': 0
   }
   ```

4. varget()
   返回 variable data, numpy.ndarray或者list()类型

   ```
   [[[429.0597  427.28278 463.54584 ... 477.38535 507.5481  477.38535]
     [428.9339  427.2775  463.4065  ... 477.5622  506.85568 477.5622 ]
     [428.7925  427.27472 463.2497  ... 477.80402 506.10434 477.80402]
     ...
     [496.5583  412.24295 522.81024 ... 455.07034 562.7776  455.07034]
     [495.14587 412.20926 521.43774 ... 455.787   562.0292  455.787  ]
     [493.69473 412.15802 520.01495 ... 456.46097 561.1974  456.46097]]]
   ```

   

