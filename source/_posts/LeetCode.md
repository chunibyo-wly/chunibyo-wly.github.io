---
title: LeetCode
typora-root-url: ..
date: 2020-01-12 02:33:08
tags:
    - LeetCode
categories:
    - 算法
mathjax: true
---
![LeetCode](/images/v2-15271eede63c6c4bbb5e8fbae0d7a06c_1200x500.jpg)

<!-- more -->

## 1 - 10
### [1\. Two Sum](https://leetcode.com/problems/two-sum/)

Difficulty: **Easy**


Given an array of integers, return **indices** of the two numbers such that they add up to a specific target.

You may assume that each input would have **_exactly_** one solution, and you may not use the _same_ element twice.

**Example:**

```
Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].
```


#### Solution

Language: **C++**

Complexity: $nlogn$

```c++
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        map<int, int> m;
        vector<int> v;
        for(int i = 0; i < nums.size(); ++i) {
            m[nums[i]] = i;
        }
        for(int i = 0; i < nums.size(); ++i) {
            cout << target - nums[i] << ' ' << m[nums[i]] <<endl;
            if(m.find(target - nums[i]) != m.end() && m[target - nums[i]] != i) {
                v.push_back(i);
                v.push_back(m[target - nums[i]]);
                break;
            }
        }
        return v;
    }
};
```

#### Advanced

Complexity: $n+logn$

```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        map<int, int> m;
        for(int i=0; i<nums.size(); ++i)
            if(m.find(target - nums[i]) == m.end())
                m[nums[i]] = i;
            else
                return {m[target - nums[i]], i};
        return {};
    }
};
```

### [2\. Add Two Numbers](https://leetcode.com/problems/add-two-numbers/)

Difficulty: **Medium**


You are given two **non-empty** linked lists representing two non-negative integers. The digits are stored in **reverse order** and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

**Example:**

```
Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
Explanation: 342 + 465 = 807.
```


#### Solution

Language: **C++**

Complexity: $O(n)$

```c++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        int tmp = 0;
        ListNode* p = new ListNode(0);
        ListNode* h = p;
        while(l1 != NULL || l2 != NULL || tmp) {
            if(l1 != NULL) tmp += l1->val, l1 = l1->next;
            if(l2 != NULL) tmp += l2->val, l2 = l2->next;
            p->next = new ListNode(tmp % 10);
            tmp = tmp / 10, p = p->next ;
        }
        return h->next ;
    }
};
```

### [3\. Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)

Difficulty: **Medium**


Given a string, find the length of the **longest substring** without repeating characters.


**Example 1:**

```
Input: "abcabcbb"
Output: 3 
Explanation: The answer is "abc", with the length of 3\. 
```


**Example 2:**

```
Input: "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
```


**Example 3:**

```
Input: "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3\. 
             Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
```


#### Solution

Language: **C++**

Complexity: $n$

```c++
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int l, r, result, a[200];
        r = l = result = 0; memset(a, 0, sizeof(a));
        for(; r < s.size(); ++r) {
            if( a[s[r]] != 0 ) {while(s[l] != s[r]) a[s[l++]] = 0; l++;}
            a[s[r]] = 1;
            result = max(result, r-l+1);
        }
        return result;
    }
};
```

#### Advanced

> 注意左指针需要修改时要小心"往回跳"的情况
>
> 这里需要用max()约束之

```cpp
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int l, result, a[200];
        l = result = 0; memset(a, -1, sizeof(a));
        for(int i=0; i < s.size(); ++i) {
            if( a[s[i]] != -1 ) l = max(l, a[s[i]]+1);
            a[s[i]] = i, result = max(result, i-l+1);
        }
        return result;
    }
};
```

### [4\. Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/)

Difficulty: **Hard**


There are two sorted arrays **nums1** and **nums2** of size m and n respectively.

Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

You may assume **nums1** and **nums2** cannot be both empty.

**Example 1:**

```
nums1 = [1, 3]
nums2 = [2]

The median is 2.0
```

**Example 2:**

```
nums1 = [1, 2]
nums2 = [3, 4]

The median is (2 + 3)/2 = 2.5
```


#### Solution

Language: **C++**

Comlexity: $O(m+n)$

```c++
class Solution {
public:
    int INF=0x3f3f3f3f;
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        nums1.push_back(INF),nums2.push_back(INF);
        double result=0,tmp=0;
        int len1=nums1.size(),len2=nums2.size(),len=len1+len2-2,l=0,r=0;
        for(int i=0;i<len;++i) { //3/2=1 0,1,2   4/2=2 0,1,2,3
            if(i==len/2) {
                if(len%2==1) return double(min(nums1[l],nums2[r]));
                else return (std::min(nums1[l],nums2[r])+tmp)/2.0;
            }
            else 
            if(nums1[l]<=nums2[r]) tmp=nums1[l],l++;
            else tmp=nums2[r],r++;
            std::cout<<l<<' '<<r<<std::endl;
        }
        return 0;
    }
};
```

#### Advanced

Complexity: $O(log(min(m,n)))$

```cpp

```

### [6\. ZigZag Conversion](https://leetcode.com/problems/zigzag-conversion/)

Difficulty: **Medium**


The string `"PAYPALISHIRING"` is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

```
P   A   H   N
A P L S I I G
Y   I   R
```

And then read line by line: `"PAHNAPLSIIGYIR"`

Write the code that will take a string and make this conversion given a number of rows:

```
string convert(string s, int numRows);
```

**Example 1:**

```
Input: s = "PAYPALISHIRING", numRows = 3
Output: "PAHNAPLSIIGYIR"
```

**Example 2:**

```
Input: s = "PAYPALISHIRING", numRows = 4
Output: "PINALSIGYAHRPI"
Explanation:

P     I    N
A   L S  I G
Y A   H R
P     I
```


#### Solution

Language: **C++**

Complexity: $O(n)$

![image-20200116174948166](/images/image-20200116174948166.png)

```c++
class Solution {
public:
    string convert(string s, int numRows) {
        string result = "";
        if(numRows == 1) return s;
        for(int i=0; i<numRows; ++i) {
            if(i==0 || i==numRows-1) for(int j=i; j<s.size(); j=j+2*numRows-2) result += s[j];
            else
                for(int j=0; j+i<s.size(); j=j+2*numRows-2) {
                    result += s[j+i];
                    if(j+2*numRows-2-i<s.size()) result += s[j+2*numRows-2-i];
                }
        }
        return result;
    }
};
```

### [7\. Reverse Integer](https://leetcode.com/problems/reverse-integer/)

Difficulty: **Easy**


Given a 32-bit signed integer, reverse digits of an integer.

**Example 1:**

```
Input: 123
Output: 321
```

**Example 2:**

```
Input: -123
Output: -321
```

**Example 3:**

```
Input: 120
Output: 21
```

**Note:**  
Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−2<sup>31</sup>,  2<sup>31 </sup>− 1]. For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.


#### Solution

Language: **C++**

Complexity: $O(len(x))$

> 注意输入的绝对值在不超过int的情况下他的翻转也会超过
> 比如说个位是9的情况

```c++
class Solution {
public:
    int reverse(int x) {
        if( x==INT_MIN || x==0 ) return 0;
        long tmp = 0;
        while(x) tmp = tmp*10 + x%10, x=x/10;
        return (tmp<INT_MAX && tmp>INT_MIN)? tmp : 0 ;
    }
};
```

### [8\. String to Integer (atoi)](https://leetcode.com/problems/string-to-integer-atoi/)

Difficulty: **Medium**


Implement `<span style="display: inline;">atoi</span>` which converts a string to an integer.

The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

If no valid conversion could be performed, a zero value is returned.

**Note:**

*   Only the space character `' '` is considered as whitespace character.
*   Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−2<sup>31</sup>,  2<sup>31 </sup>− 1]. If the numerical value is out of the range of representable values, INT_MAX (2<sup>31 </sup>− 1) or INT_MIN (−2<sup>31</sup>) is returned.

**Example 1:**

```
Input: "42"
Output: 42
```

**Example 2:**

```
Input: "   -42"
Output: -42
Explanation: The first non-whitespace character is '-', which is the minus sign.
             Then take as many numerical digits as possible, which gets 42.
```

**Example 3:**

```
Input: "4193 with words"
Output: 4193
Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.
```

**Example 4:**

```
Input: "words and 987"
Output: 0
Explanation: The first non-whitespace character is 'w', which is not a numerical 
             digit or a +/- sign. Therefore no valid conversion could be performed.
```

**Example 5:**

```
Input: "-91283472332"
Output: -2147483648
Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer.
             Thefore INT_MIN (−231) is returned.
```


#### Solution

Language: **C++**

Complexity: $O(n)$

```c++
class Solution {
public:
    bool _isDigit(char x) {return ('0'<=x && x<='9');}
    
    int myAtoi(string s) {
        int i=0, flag=0;
        long tmp=0;
        for(; i<s.size(); ++i) {
            
            if( (s[i]==' ' && flag==0) || s[i] == '0') {if(flag==0 && s[i]=='0') {flag=1;} }
            else if( s[i]=='+' && flag==0) flag = 1;
            else if( s[i]=='-' && flag==0) flag =-1;
            else if(_isDigit(s[i])){ if(flag==0) flag=1; break;}
            else return 0;
        }
        
        int _i = i;
        for(; i<s.size(); ++i) {
            if(!_isDigit(s[i])) break;
            if(i-_i+1 > 10) return (flag > 0) ? INT_MAX : INT_MIN;
            tmp = tmp*10 + (s[i]-'0');
        }
        tmp *= flag;
        if(tmp>=INT_MAX) return INT_MAX;
        else if(tmp<=INT_MIN) return INT_MIN;
        else return tmp;
    }
};
```