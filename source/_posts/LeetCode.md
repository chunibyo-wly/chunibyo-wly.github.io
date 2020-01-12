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