---
title: LeetCode
typora-root-url: ..
date: 2020-01-12 02:33:08
tags:
---
![LeetCode](/images/v2-15271eede63c6c4bbb5e8fbae0d7a06c_1200x500.jpg)

<!-- more -->

# 001 - 100

## [001 Two Sum](https://leetcode.com/problems/two-sum/)

1. Mine ($nlogn$)

   ```cpp
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

2. Most Votes

   ```cpp
   class Solution {
   public:
       vector<int> twoSum(vector<int>& nums, int target) {
           unordered_map<int, int> indices;
           for (int i = 0; i < nums.size(); i++) {
               if (indices.find(target - nums[i]) != indices.end()) {
                   return {indices[target - nums[i]], i};
               }
               indices[nums[i]] = i;
           }
           return {};
       }
   };
   ```