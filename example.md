<div align='center' ><font size='70'>题目+分类</font></div>

# 题目描述

[题目链接]("https://leetcode-cn.com/problems/running-sum-of-1d-array/") 

给你一个数组 nums 。数组「动态和」的计算公式为：runningSum[i] = sum(nums[0]…nums[i]) 。

请返回 nums 的动态和。

示例 1：

输入：nums = [1,2,3,4]
输出：[1,3,6,10]
解释：动态和计算过程为 [1, 1+2, 1+2+3, 1+2+3+4] 。
示例 2：

输入：nums = [1,1,1,1,1]
输出：[1,2,3,4,5]
解释：动态和计算过程为 [1, 1+1, 1+1+1, 1+1+1+1, 1+1+1+1+1] 。

# 解题思路
直接累加即可。

# 代码

```
class Solution {
    public int[] runningSum(int[] nums) {
        
        int[] ans = new int[nums.length];

        ans[0] = nums[0];
        for(int i = 1; i < nums.length; i++) {
            ans[i] = ans[i - 1] + nums[i];
        }

        return ans;

    }
}
```

