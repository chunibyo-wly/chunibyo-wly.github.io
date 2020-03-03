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

#### Advanced

```cpp
class Solution {
public:
    bool _isDigit(char x) {return ('0'<=x && x<='9');}
    
    int myAtoi(string s) {
        int flag=1, i=0;
        long tmp=0;
        
        for(; s[i]==' '; ++i) ;
        
        if(s[i]=='+' || s[i]=='-') flag = 1 - 2*(s[i++]=='-');
        
        for(; _isDigit(s[i]) && i<s.size(); ++i) {
            tmp = tmp*10 + (s[i]-'0');
            if(tmp > INT_MAX) return (flag > 0) ? INT_MAX : INT_MIN;
        }
        
        return tmp * flag;
    }
};
```

这个用来判断正负的写法很不错

```cpp
if(s[i]=='+' || s[i]=='-') flag = 1 - 2*(s[i++]=='-');
```

### [9\. Palindrome Number](https://leetcode.com/problems/palindrome-number/)

Difficulty: **Easy**


Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.

**Example 1:**

```
Input: 121
Output: true
```

**Example 2:**

```
Input: -121
Output: false
Explanation: From left to right, it reads -121\. From right to left, it becomes 121-. Therefore it is not a palindrome.
```

**Example 3:**

```
Input: 10
Output: false
Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
```

**Follow up:**

Coud you solve it without converting the integer to a string?


#### Solution

Language: **C++**

```c++
class Solution {
public:
    bool isPalindrome(int x) {
        if(x<0) return false;
        if(x/10 == 0) return true;
        int i=1, a[12];
        while(x) a[i++] = x%10, x/=10;
        for(int j=1; j<=(i-1)/2; ++j) if(a[j] != a[i-j]) return false;
        return true;
    }
};
```

#### Advanced

```cpp
class Solution {
public:
    bool isPalindrome(int x) {
        if(x<0|| (x!=0 &&x%10==0)) return false;
        int sum=0;
        while(x>sum) sum = sum*10+x%10, x /= 10;
        return (x==sum)||(x==sum/10);
    }
};
```

## 11 - 20

### [11\. Container With Most Water](https://leetcode.com/problems/container-with-most-water/)

Difficulty: **Medium**


Given _n_ non-negative integers _a<sub style="display: inline;">1</sub>_, _a<sub style="display: inline;">2</sub>_, ..., _a<sub style="display: inline;">n </sub>_, where each represents a point at coordinate (_i_, _a<sub style="display: inline;">i</sub>_). _n_ vertical lines are drawn such that the two endpoints of line _i_ is at (_i_, _a<sub style="display: inline;">i</sub>_) and (_i_, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.

**Note: **You may not slant the container and _n_ is at least 2.

![](/images/question_11.jpg)

<small style="display: inline;">The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49\.</small>

**Example:**

```
Input: [1,8,6,2,5,4,8,3,7]
Output: 49
```


#### Solution

Language: **C++**

Complexity: $O(n)$

> 开始困惑我的地方是为什么可以贪心的选柱子
>
> 因为如果未来有更优的情况的下丢弃当前最劣情况是最优策略

```c++
class Solution {
public:
    int maxArea(vector<int>& height) {
        if(height.size()==2) return min(height[0], height[1]);
        
        int l=0, r=height.size()-1, tmp=0;
        while(l != r) {
            tmp = max(tmp, (r-l)*min(height[l], height[r]));
            if(height[l] <= height[r]) l++;
            else r--;
        }
        return tmp;
    }
};
```

### [12\. Integer to Roman](https://leetcode.com/problems/integer-to-roman/)

Difficulty: **Medium**


Roman numerals are represented by seven different symbols: `I`, `V`, `X`, `L`, `C`, `D` and `M`.

```
Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
```

For example, two is written as `II` in Roman numeral, just two one's added together. Twelve is written as, `XII`, which is simply `X` + `II`. The number twenty seven is written as `XXVII`, which is `XX` + `V` + `II`.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not `IIII`. Instead, the number four is written as `IV`. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as `IX`. There are six instances where subtraction is used:

*   `I` can be placed before `V` (5) and `X` (10) to make 4 and 9. 
*   `X` can be placed before `L` (50) and `C` (100) to make 40 and 90. 
*   `C` can be placed before `D` (500) and `M` (1000) to make 400 and 900.

Given an integer, convert it to a roman numeral. Input is guaranteed to be within the range from 1 to 3999.

**Example 1:**

```
Input: 3
Output: "III"
```

**Example 2:**

```
Input: 4
Output: "IV"
```

**Example 3:**

```
Input: 9
Output: "IX"
```

**Example 4:**

```
Input: 58
Output: "LVIII"
Explanation: L = 50, V = 5, III = 3.
```

**Example 5:**

```
Input: 1994
Output: "MCMXCIV"
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
```


#### Solution

Language: **C++**

Complexity: $O(1)$

```c++
class Solution {
public:
    string intToRoman(int num) {
        string A[] = {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};
        string B[] = {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"};
        string C[] = {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"};
        string D[] = {"", "M", "MM", "MMM"};
        
        return D[num/1000%10] + 
               C[num/100%10] +
               B[num/10%10] +
               A[num/1%10];
    }
};
```

### [13\. Roman to Integer](https://leetcode.com/problems/roman-to-integer/)

Difficulty: **Easy**


Roman numerals are represented by seven different symbols: `I`, `V`, `X`, `L`, `C`, `D` and `M`.

```
Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
```

For example, two is written as `II` in Roman numeral, just two one's added together. Twelve is written as, `XII`, which is simply `X` + `II`. The number twenty seven is written as `XXVII`, which is `XX` + `V` + `II`.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not `IIII`. Instead, the number four is written as `IV`. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as `IX`. There are six instances where subtraction is used:

*   `I` can be placed before `V` (5) and `X` (10) to make 4 and 9. 
*   `X` can be placed before `L` (50) and `C` (100) to make 40 and 90. 
*   `C` can be placed before `D` (500) and `M` (1000) to make 400 and 900.

Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.

**Example 1:**

```
Input: "III"
Output: 3
```

**Example 2:**

```
Input: "IV"
Output: 4
```

**Example 3:**

```
Input: "IX"
Output: 9
```

**Example 4:**

```
Input: "LVIII"
Output: 58
Explanation: L = 50, V= 5, III = 3.
```

**Example 5:**

```
Input: "MCMXCIV"
Output: 1994
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
```


#### Solution

Language: **C++**

```c++
class Solution {
public:
    int romanToInt(string s) {
        int a[200], tmp=0;
        a['I'] = 1;
        a['V'] = 5;
        a['X'] = 10;
        a['L'] = 50;
        a['C'] = 100;
        a['D'] = 500;
        a['M'] = 1000;
        for(int i=0; i<s.size(); ++i) {
            tmp += a[s[i]];
            if(i!=0 && a[s[i-1]]<a[s[i]]) tmp-=2*a[s[i-1]];
        }
        return tmp;
    }
};
```

### [14\. Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix/)

Difficulty: **Easy**


Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string `""`.

**Example 1:**

```
Input: ["flower","flow","flight"]
Output: "fl"
```

**Example 2:**

```
Input: ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
```

**Note:**

All given inputs are in lowercase letters `a-z`.


#### Solution

Language: **C++**

```c++
class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        if(strs.size() == 0) return "";
        if(strs.size() == 1) return strs[0];
        string re = "";
        
        int i=0;
        char tmp;
        while(i<strs[0].size()) {
            tmp = strs[0][i];
            for(int j=0; j<strs.size(); ++j)
                if(i>=strs[j].size() || strs[j][i] != tmp) return re;
            re+= tmp, i++;
        }
        return re;
    }
};
```

Advanced

> 把对string的维护换成substr快了一倍

```cpp
class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        if(strs.size() == 0) return "";
        if(strs.size() == 1) return strs[0];
        string re = "";
        
        int i=0;
        char tmp;
        while(i<strs[0].size()) {
            tmp = strs[0][i];
            for(int j=0; j<strs.size(); ++j)
                if(i>=strs[j].size() || strs[j][i] != tmp) return strs[0].substr(0, i);
            i++;
        }
        return strs[0].substr(0, i);
    }
};
```

### [15\. 3Sum](https://leetcode.com/problems/3sum/)

Difficulty: **Medium**


Given an array `nums` of _n_ integers, are there elements _a_, _b_, _c_ in `nums` such that _a_ + _b_ + _c_ = 0? Find all unique triplets in the array which gives the sum of zero.

**Note:**

The solution set must not contain duplicate triplets.

**Example:**

```
Given array nums = [-1, 0, 1, 2, -1, -4],

A solution set is:
[
  [-1, 0, 1],
  [-1, -1, 2]
]
```


#### Solution

Language: **C++**

Complexity: $O(n^{2})$

```c++
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        vector<vector<int>> re;
        if(nums.size() <= 2) return re;
        sort(nums.begin(), nums.end());
        for(int i=0; i<nums.size()-2; ++i) {
            if(i!=0 && nums[i]==nums[i-1]) continue;
            int l = i+1, r = nums.size()-1;
            while(l<r) {
                int sum = nums[i] + nums[l] + nums[r];
                if(sum == 0) {
                    re.push_back({nums[i], nums[l], nums[r]});
                    while( l<r && nums[l] == nums[l+1] ) l++;
                    while( l<r && nums[r-1] == nums[r] ) r--;
                    r--; l++;
                }
                else if(sum < 0) l++;
                else if(sum > 0) r--;
            }
        }
        return re;
    }
};
```

### [16\. 3Sum Closest](https://leetcode.com/problems/3sum-closest/)

Difficulty: **Medium**


Given an array `nums` of _n_ integers and an integer `target`, find three integers in `nums` such that the sum is closest to `target`. Return the sum of the three integers. You may assume that each input would have exactly one solution.

**Example:**

```
Given array nums = [-1, 2, 1, -4], and target = 1.

The sum that is closest to the target is 2\. (-1 + 2 + 1 = 2).
```


#### Solution

Language: **C++**

Complexity: $O(n^{2})$

```c++
class Solution {
public:
    int threeSumClosest(vector<int>& nums, int target) {
        if(nums.size() == 3) return nums[0]+nums[1]+nums[2];
        
        int re, _min=INT_MAX;
        sort(nums.begin(), nums.end());
        for(int i=0; i<nums.size()-2; ++i) {
            int l = i+1, r = nums.size()-1;
            while(l<r) {
                int sum = nums[i]+nums[l]+nums[r];
                
                if(abs(sum-target) < _min) re = sum, _min = abs(sum-target);
                
                if(sum > target) r--;
                else if(sum < target) l++;
                else return re;
            }
        }
        return re;
    }
};
```

### [17\. Letter Combinations of a Phone Number](https://leetcode.com/problems/letter-combinations-of-a-phone-number/)

Difficulty: **Medium**


Given a string containing digits from `2-9` inclusive, return all possible letter combinations that the number could represent.

A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

![](/images/200px-Telephone-keypad2.svg.png)

**Example:**

```
Input: "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
```

**Note:**

Although the above answer is in lexicographical order, your answer could be in any order you want.


#### Solution 1

Language: **C++**

```c++
class Solution {
public:
    vector<string> m = {
        "",
        "",     "abc", "def",
        "ghi",  "jkl", "mno",
        "pqrs", "tuv", "wxyz"
    };
    
    void dfs(string digits, int index, string tmp, vector<string>& re) {
        if(index == digits.size()-1)
            for(auto i : m[digits[index]-'0'])
                re.push_back(tmp+i);
        else
            for(auto i : m[digits[index]-'0'])
                dfs(digits, index+1, tmp+i, re);
    }
    
    vector<string> letterCombinations(string digits) {
        if(digits == "") return {};
        vector<string> re;
        dfs(digits, 0, "", re);
        return re;
    }
};
```

#### Solution 2

> queue代替的递归版

```cpp
class Solution {
public:
    vector<string> m = {
        "",
        "",     "abc", "def",
        "ghi",  "jkl", "mno",
        "pqrs", "tuv", "wxyz"
    };
    
    vector<string> letterCombinations(string digits) {
        if(digits == "") return {};
        vector<string> re;
        queue<string> q;
        
        q.push("");
        while(q.front().size() != digits.size()) {
            string tmp = q.front(); q.pop();
            for(auto i : m[digits[tmp.size()]-'0']) q.push(tmp+i);
        }
        while(!q.empty()) {re.push_back(q.front()); q.pop();}
        return re;
    }
};
```

### [18\. 4Sum](https://leetcode.com/problems/4sum/)

Difficulty: **Medium**


Given an array `nums` of _n_ integers and an integer `target`, are there elements _a_, _b_, _c_, and _d_ in `nums` such that _a_ + _b_ + _c_ + _d_ = `target`? Find all unique quadruplets in the array which gives the sum of `target`.

**Note:**

The solution set must not contain duplicate quadruplets.

**Example:**

```
Given array nums = [1, 0, -1, 0, -2, 2], and target = 0.

A solution set is:
[
  [-1,  0, 0, 1],
  [-2, -1, 1, 2],
  [-2,  0, 0, 2]
]
```


#### Solution

Language: **C++**

Complexity: $O(n^{3})$

```c++
class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        vector<vector<int>> re;
        if(nums.size() <= 3) return re;
        sort(nums.begin(), nums.end());
        for(int i=0; i<nums.size(); ++i) {
            if(i!=0 && nums[i]==nums[i-1]) continue;
            for(int j=i+1; j<nums.size(); ++j) {
                if(j!=i+1 && nums[j]==nums[j-1]) continue;
                int l=j+1, r=nums.size()-1;
                while(l < r) {
                    int sum = nums[i]+nums[j]+nums[l]+nums[r];
                    if(sum == target) {
                        re.push_back({nums[i], nums[j], nums[l], nums[r]});
                        while( l<r && nums[l] == nums[l+1] ) l++;
                        while( l<r && nums[r-1] == nums[r] ) r--;
                        r--; l++;
                    }
                    else if(sum < target) l++;
                    else if(sum > target) r--;
                }
            }
        }
        return re;
    }
};
```

### [19\. Remove Nth Node From End of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)

Difficulty: **Medium**


Given a linked list, remove the _n_-th node from the end of list and return its head.

**Example:**

```
Given linked list: 1->2->3->4->5, and n = 2.

After removing the second node from the end, the linked list becomes 1->2->3->5.
```

**Note:**

Given _n_ will always be valid.

**Follow up:**

Could you do this in one pass?


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
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        if(n==0) return head;
        
        ListNode *l=head, *r=head;
        while(n--) r=r->next;
        if(r==nullptr) return head->next;
        while(r->next != nullptr) l=l->next, r=r->next; l->next=l->next->next;
        return head;
    }
};
```

### [20\. Valid Parentheses](https://leetcode.com/problems/valid-parentheses/)

Difficulty: **Easy**


Given a string containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

An input string is valid if:

1.  Open brackets must be closed by the same type of brackets.
2.  Open brackets must be closed in the correct order.

Note that an empty string is also considered valid.

**Example 1:**

```
Input: "()"
Output: true
```

**Example 2:**

```
Input: "()[]{}"
Output: true
```

**Example 3:**

```
Input: "(]"
Output: false
```

**Example 4:**

```
Input: "([)]"
Output: false
```

**Example 5:**

```
Input: "{[]}"
Output: true
```


#### Solution

Language: **C++**

```c++
class Solution {
public:
    bool isValid(string str) {
        stack<char> s;
        map<char, char> m;
        m[')']='(', m['}']='{', m[']']='[';
        m['(']=' ', m['{']=' ', m['[']=' ';
        for(auto i : str) {
            if(!s.empty() && m[i]==s.top()) s.pop();
            else if(m[i]!=' ') return false;
            else s.push(i);
        }
        if(s.empty()) return true;
        else return false;
    }
};
```

## 21 - 30

### [21\. Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)

Difficulty: **Easy**


Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

**Example:**

```
Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4
```


#### Solution

Language: **C++**

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
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        ListNode *p, *head;
        p = head = new ListNode(0);
        while(l1!=nullptr && l2!=nullptr) {
            if(l1->val <= l2->val) p->next=l1, p=p->next, l1=l1->next;
            else p->next=l2, p=p->next, l2=l2->next;
        }
        if(l1!=nullptr) p->next=l1;
        else if(l2!=nullptr) p->next=l2;
        return head->next;
    }
};
```

Advanced

> 尾递归版

```cpp
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
    void merge(ListNode* l1, ListNode* l2, ListNode* tmp) {
        if(l1==nullptr) {tmp->next=l2; return; }
        if(l2==nullptr) {tmp->next=l1; return; }
        if(l1->val <= l2->val)
            tmp->next=l1, tmp=tmp->next, merge(l1->next, l2, tmp);
        else
            tmp->next=l2, tmp=tmp->next, merge(l1, l2->next, tmp);
    }
    
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        ListNode* tmp=new ListNode(0);
        merge(l1, l2, tmp);
        return tmp->next;
    }
};
```

### [22\. Generate Parentheses](https://leetcode.com/problems/generate-parentheses/)

Difficulty: **Medium**


Given _n_ pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

For example, given _n_ = 3, a solution set is:

```
[
  "((()))",
  "(()())",
  "(())()",
  "()(())",
  "()()()"
]
```


#### Solution

Language: **C++**

> 尾递归

```c++
class Solution {
public:
    void dfs(vector<string>&v, string tmp, int a, int b, int n) {
        if(a==n && b==n) v.push_back(tmp);
        else {
            if(a<n) dfs(v, tmp+"(", a+1, b, n);
            if(b<a) if(tmp[tmp.size()-1]=='(' || tmp[tmp.size()-1]==')') dfs(v, tmp+")", a, b+1, n);
        }
    }
    
    vector<string> generateParenthesis(int n) {
        vector<string> v;
        dfs(v, "", 0, 0, n);
        return v;
    }
};
```

### [23\. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)

Difficulty: **Hard**


Merge _k_ sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

**Example:**

```
Input:
[
  1->4->5,
  1->3->4,
  2->6
]
Output: 1->1->2->3->4->4->5->6
```


#### Solution

Language: **C++**

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
    ListNode* merge(ListNode* l1, ListNode* l2) {
        if(l1==nullptr) return l2;
        if(l2==nullptr) return l1;
        if(l1->val < l2->val) {
            l1->next = merge(l1->next,l2);
            return l1;
        } else {
            l2->next = merge(l1,l2->next);
            return l2;
        }
    }
    
    ListNode* mergeK(vector<ListNode*> lists) {
        if(lists.size()==2) return merge(lists[0], lists[1]);
        else {
            ListNode* tmp=lists.back();
            lists.pop_back();
            return merge(tmp, mergeK(lists));
        }
    }
    
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        if(lists.size()==0) return nullptr;
        if(lists.size()==1) return lists[0];
        return mergeK(lists);
    }
};
```

### [24\. Swap Nodes in Pairs](https://leetcode.com/problems/swap-nodes-in-pairs/)

Difficulty: **Medium**


Given a linked list, swap every two adjacent nodes and return its head.

You may **not** modify the values in the list's nodes, only nodes itself may be changed.

**Example:**

```
Given 1->2->3->4, you should return the list as 2->1->4->3.
```


#### Solution

Language: **C++**

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
    ListNode* swapPairs(ListNode* head) {
        if(head==nullptr || head->next==nullptr) return head;
        ListNode *p, *first, *second;
        p=new ListNode(0), p->next=head, head=head->next;
        while(p!=nullptr && p->next!=nullptr && p->next->next!=nullptr) {
            first=p->next, second=p->next->next;
            
            first->next=second->next;
            second->next=first;
            p->next=second;
            
            p=p->next->next;
        }
        return head;
    }
};
```

```cpp
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
    ListNode* swapPairs(ListNode* head) {
        if(head==nullptr || head->next==nullptr) return head;
        ListNode *first, *second;
        first=head, second=head->next;
        first->next=swapPairs(second->next), second->next=first;
        return second;
    }
};
```

### [26\. Remove Duplicates from Sorted Array](https://leetcode.com/problems/remove-duplicates-from-sorted-array/)

Difficulty: **Easy**


Given a sorted array _nums_, remove the duplicates such that each element appear only _once_ and return the new length.

Do not allocate extra space for another array, you must do this by **modifying the input array** with O(1) extra memory.

**Example 1:**

```
Given nums = [1,1,2],

Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively.

It doesn't matter what you leave beyond the returned length.
```

**Example 2:**

```
Given nums = [0,0,1,1,1,2,2,3,3,4],

Your function should return length = 5, with the first five elements of nums being modified to 0, 1, 2, 3, and 4 respectively.

It doesn't matter what values are set beyond the returned length.
```

**Clarification:**

Confused why the returned value is an integer but your answer is an array?

Note that the input array is passed in by **reference**, which means modification to the input array will be known to the caller as well.

Internally you can think of this:

```
// nums is passed in by reference. (i.e., without making a copy)
int len = removeDuplicates(nums);

// any modification to nums in your function would be known by the caller.
// using the length returned by your function, it prints the first len elements.
for (int i = 0; i < len; i++) {
    print(nums[i]);
}
```


#### Solution

Language: **C++**

```c++
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        int cnt=0;
        for(int i=0;i<nums.size();++i)
            if(i==0 || nums[i]!=nums[i-1])
                nums[cnt++]=nums[i];
        return cnt;
    }
};
```

### [27\. Remove Element](https://leetcode.com/problems/remove-element/)

Difficulty: **Easy**


Given an array _nums_ and a value _val_, remove all instances of that value and return the new length.

Do not allocate extra space for another array, you must do this by **modifying the input array** with O(1) extra memory.

The order of elements can be changed. It doesn't matter what you leave beyond the new length.

**Example 1:**

```
Given nums = [3,2,2,3], val = 3,

Your function should return length = 2, with the first two elements of nums being 2.

It doesn't matter what you leave beyond the returned length.
```

**Example 2:**

```
Given nums = [0,1,2,2,3,0,4,2], val = 2,

Your function should return length = 5, with the first five elements of nums containing 0, 1, 3, 0, and 4.

Note that the order of those five elements can be arbitrary.

It doesn't matter what values are set beyond the returned length.
```

**Clarification:**

Confused why the returned value is an integer but your answer is an array?

Note that the input array is passed in by **reference**, which means modification to the input array will be known to the caller as well.

Internally you can think of this:

```
// nums is passed in by reference. (i.e., without making a copy)
int len = removeElement(nums, val);

// any modification to nums in your function would be known by the caller.
// using the length returned by your function, it prints the first len elements.
for (int i = 0; i < len; i++) {
    print(nums[i]);
}
```


#### Solution

Language: **C++**

```c++
class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        int l=0, r=nums.size()-1;
        while(l-r<1) {
            if(nums[r]!=val && nums[l]==val) swap(nums[l], nums[r]);
            if(nums[r]==val) r--;
            if(nums[l]!=val) l++;
        }
        return l;
    }
};
```

## 31 - 40

### [35\. Search Insert Position](https://leetcode.com/problems/search-insert-position/)

Difficulty: **Easy**


Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You may assume no duplicates in the array.

**Example 1:**

```
Input: [1,3,5,6], 5
Output: 2
```

**Example 2:**

```
Input: [1,3,5,6], 2
Output: 1
```

**Example 3:**

```
Input: [1,3,5,6], 7
Output: 4
```

**Example 4:**

```
Input: [1,3,5,6], 0
Output: 0
```


#### Solution

Language: **C++**

```c++
class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        if(nums.size()==0 || target<=nums[0]) return 0;
        for (int i=0; i<nums.size()-1; ++i) 
            if(nums[i]<target && target<=nums[i+1]) return i+1;
        return nums.size();
    }
};
```

### [36\. Valid Sudoku](https://leetcode.com/problems/valid-sudoku/)

Difficulty: **Medium**


Determine if a 9x9 Sudoku board is valid. Only the filled cells need to be validated **according to the following rules**:

1.  Each row must contain the digits `1-9` without repetition.
2.  Each column must contain the digits `1-9` without repetition.
3.  Each of the 9 `3x3` sub-boxes of the grid must contain the digits `1-9` without repetition.

![](/images/250px-Sudoku-by-L2G-20050714.svg.png)  
<small style="display: inline;">A partially filled sudoku which is valid.</small>

The Sudoku board could be partially filled, where empty cells are filled with the character `'.'`.

**Example 1:**

```
Input:
[
  ["5","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]
Output: true
```

**Example 2:**

```
Input:
[
  ["8","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]
Output: false
Explanation: Same as Example 1, except with the 5 in the top left corner being 
    modified to 8\. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
```

**Note:**

*   A Sudoku board (partially filled) could be valid but is not necessarily solvable.
*   Only the filled cells need to be validated according to the mentioned rules.
*   The given board contain only digits `1-9` and the character `'.'`.
*   The given board size is always `9x9`.


#### Solution

Language: **C++**

```c++
class Solution {
public:
    bool isValidSudoku(vector<vector<char>>& board) {
        bool row[10][10] = {0}, col[10][10] = {0}, cel[10][10] = {0};
            for(int i=0; i<board.size(); ++i) {
                for(int j=0; j<board.size(); ++j) {
                    if(board[i][j] == '.') continue;
                    int v = board[i][j]-'0';
                    if(!row[i][v] && !col[j][v] && !cel[i/3*3+j/3+1][v]) 
                        row[i][v] = col[j][v] = cel[i/3*3+j/3+1][v] = 1;
                    else return false;
                }
            }
        return true;
    }
};
```

### [37\. Sudoku Solver](https://leetcode.com/problems/sudoku-solver/)

Difficulty: **Hard**


Write a program to solve a Sudoku puzzle by filling the empty cells.

A sudoku solution must satisfy **all of the following rules**:

1.  Each of the digits `1-9` must occur exactly once in each row.
2.  Each of the digits `1-9` must occur exactly once in each column.
3.  Each of the the digits `1-9` must occur exactly once in each of the 9 `3x3` sub-boxes of the grid.

Empty cells are indicated by the character `'.'`.

![](/images/250px-Sudoku-by-L2G-20050714.svg-1582790921586.png)  
<small style="display: inline;">A sudoku puzzle...</small>

![](/images/250px-Sudoku-by-L2G-20050714_solution.svg.png)  
<small style="display: inline;">...and its solution numbers marked in red.</small>

**Note:**

*   The given board contain only digits `1-9` and the character `'.'`.
*   You may assume that the given Sudoku puzzle will have a single unique solution.
*   The given board size is always `9x9`.


#### Solution

Language: **C++**

```c++
class Solution {
    public:
    bool row[10][10] = {0}, col[10][10] = {0}, cel[10][10] = {0};

    bool check(int x, int y, int v) {
        return !row[x][v] && !col[y][v] && !cel[x/3*3+y/3+1][v];
    }

    bool dfs(int x, int y, vector<vector<char>>&board) {
        while(x<=8 && y<=8 && board[x][y]!='.')
            y=y+(x+1)/9, x=(x+1)%9;
        if(y>8) return true;
        for(int i=1; i<=9; ++i) {
            if(check(x, y, i)) {
                row[x][i] = col[y][i] = cel[x/3*3+y/3+1][i] = 1;
                board[x][y] = char(i+'0');
                if(dfs(x, y, board)) return true;
                board[x][y] = '.';
                row[x][i] = col[y][i] = cel[x/3*3+y/3+1][i] = 0;
            }
        }
        return false;
    }

    void solveSudoku(vector<vector<char>>& board) {
        for(int i=0; i<board.size(); ++i) {
            for(int j=0; j<board.size(); ++j) {
                if(board[i][j] == '.') continue;
                int v = board[i][j]-'0';
                row[i][v] = col[j][v] = cel[i/3*3+j/3+1][v] = 1;
            }
        }
        dfs(0, 0, board);
    }
};
```

### [38\. Count and Say](https://leetcode.com/problems/count-and-say/)

Difficulty: **Easy**


The count-and-say sequence is the sequence of integers with the first five terms as following:

```
1\.     1
2\.     11
3\.     21
4\.     1211
5\.     111221
```

`1` is read off as `"one 1"` or `11`.  
`11` is read off as `"two 1s"` or `21`.  
`21` is read off as `"one 2`, then `one 1"` or `1211`.

Given an integer _n_ where 1 ≤ _n_ ≤ 30, generate the _n_<sup>th</sup> term of the count-and-say sequence. You can do so recursively, in other words from the previous member read off the digits, counting the number of digits in groups of the same digit.

Note: Each term of the sequence of integers will be represented as a string.

**Example 1:**

```
Input: 1
Output: "1"
Explanation: This is the base case.
```

**Example 2:**

```
Input: 4
Output: "1211"
Explanation: For n = 3 the term was "21" in which we have two groups "2" and "1", "2" can be read as "12" which means frequency = 1 and value = 2, the same way "1" is read as "11", so the answer is the concatenation of "12" and "11" which is "1211".
```


#### Solution

Language: **C++**

```c++
class Solution {
    public:
    string countAndSay(int n) {
        if(n==1) return "1";
        string s = countAndSay(n-1) + '@';
        int cnt=0;
        string result="";
        for(int i=1; i<s.size(); ++i) {
            cnt++;
            if(i!=0 && s[i]!=s[i-1]) {
                result+=(cnt+'0');
                result+=s[i-1];
                cnt=0;
            }
        }
        return result;
    }
};
```

### [39\. Combination Sum](https://leetcode.com/problems/combination-sum/)

Difficulty: **Medium**


Given a **set** of candidate numbers (`candidates`) **(without duplicates)** and a target number (`target`), find all unique combinations in `candidates` where the candidate numbers sums to `target`.

The **same** repeated number may be chosen from `candidates` unlimited number of times.

**Note:**

*   All numbers (including `target`) will be positive integers.
*   The solution set must not contain duplicate combinations.

**Example 1:**

```
Input: candidates = [2,3,6,7], target = 7,
A solution set is:
[
  [7],
  [2,2,3]
]
```

**Example 2:**

```
Input: candidates = [2,3,5], target = 8,
A solution set is:
[
  [2,2,2,2],
  [2,3,3],
  [3,5]
]
```


#### Solution

Language: **C++**

```c++
class Solution {
public:
    void dfs(vector<vector<int>>&result, vector<int>&tmp, vector<int>&candidates, int ordinal, int target) {
        if (target==0) result.push_back(tmp);
        for(int i=ordinal; i<candidates.size(); ++i)
            if(candidates[i]<=target) {tmp.push_back(candidates[i]); dfs(result, tmp, candidates, i,target-candidates[i]); tmp.pop_back();}
    }
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> result;
        vector<int> tmp;
        dfs(result, tmp,candidates, 0, target);
        return result;
    }
};
```

### [40\. Combination Sum II](https://leetcode.com/problems/combination-sum-ii/)

Difficulty: **Medium**


Given a collection of candidate numbers (`candidates`) and a target number (`target`), find all unique combinations in `candidates` where the candidate numbers sums to `target`.

Each number in `candidates` may only be used **once** in the combination.

**Note:**

*   All numbers (including `target`) will be positive integers.
*   The solution set must not contain duplicate combinations.

**Example 1:**

```
Input: candidates = [10,1,2,7,6,1,5], target = 8,
A solution set is:
[
  [1, 7],
  [1, 2, 5],
  [2, 6],
  [1, 1, 6]
]
```

**Example 2:**

```
Input: candidates = [2,5,2,1,2], target = 5,
A solution set is:
[
  [1,2,2],
  [5]
]
```


#### Solution

Language: **C++**

```c++
class Solution {
public:
    void dfs(vector<vector<int>>&result, vector<int>&tmp, vector<int>&candidates, int ordinal, int target) {
        if (target==0) result.push_back(tmp);
        for(int i=ordinal; i<candidates.size(); ++i) {
            if(candidates[i]<=target) {
                if(i>ordinal && candidates[i]==candidates[i-1]) continue;
                tmp.push_back(candidates[i]); 
                dfs(result, tmp, candidates, i+1, target-candidates[i]); 
                tmp.pop_back();
            }
        }
    }
    
    vector<vector<int>> combinationSum2(vector<int>& candidates, int target) {
        vector<vector<int>> result;
        vector<int> tmp;
        sort(candidates.begin(), candidates.end());
        dfs(result, tmp,candidates, 0, target);
        return result;
    }
};
```

## 41 - 50

### [41\. First Missing Positive](https://leetcode.com/problems/first-missing-positive/)

Difficulty: **Hard**


Given an unsorted integer array, find the smallest missing positive integer.

**Example 1:**

```
Input: [1,2,0]
Output: 3
```

**Example 2:**

```
Input: [3,4,-1,1]
Output: 2
```

**Example 3:**

```
Input: [7,8,9,11,12]
Output: 1
```

**Note:**

Your algorithm should run in _O_(_n_) time and uses constant extra space.

#### Solution

> 有一个要注意的地方是, 需要检查的地方是索引后的位置
>
> 检查当前值因为有重复所以会死循环

Language: **C++**

```c++
class Solution {
public:
    int firstMissingPositive(vector<int>& nums) {
        for(int i=0; i<nums.size(); ++i) {
            while(nums[i]>0 && nums[i]<=nums.size() && nums[nums[i]-1]!=nums[i]) {
                    cout<<i<<nums[i]-1<<endl;
                    swap(nums[i], nums[nums[i]-1]);
            }
        }
        int i;
        for(i=0; i<nums.size(); ++i) {
            if(nums[i]<=0 || nums[i]>nums.size() || i!=nums[i]-1) break;
        }
        return i+1;
    }
};
```