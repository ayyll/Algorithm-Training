<div align='center' ><font size='70'>重新排列数组</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/shuffle-the-array/" target="_blank">题目链接</a>

题目描述 

给你一个数组 nums ，数组中有 2n 个元素，按 [x1,x2,...,xn,y1,y2,...,yn] 的格式排列。

请你将数组按 [x1,y1,x2,y2,...,xn,yn] 格式重新排列，返回重排后的数组。

示例 ：

输入： nums = [2,5,1,3,4,7], n = 3

输出：[2,3,5,4,1,7] 

解释：由于 x1=2, x2=5, x3=1, y1=3, y2=4, y3=7 ，所以答案为 [2,3,5,4,1,7]

# 解题思路

可以观察出，我们奇偶交替填充，nums[2i] {新数组} = nums[i] {旧数组} nums[2i + 1] {新数组} = nums[n + i] {旧数组}

如果是空间复杂度为O(n)的解法，很简单，只需要拷贝一下nums数组，直接重填nums即可。

下面考虑空间复杂度为O(1)的解法，可以看到题目给定nums[i]的范围是[1,1000]，也就是说nums[i]只占用了int的低10位，而前面的高位都没有利用到，我们用**低10位**来保存原来的nums[i]，用**高10位**来保存交换后的nums[i],这样信息就不会冲突了，等交换完毕后，再右移十位，把低十位的数据刷掉，剩下的就是重新排列后的数组。（这个思路太帅了，我是从评论区看到的，自己想了半天也没想到位运算上去，主要是根本没注意数据范围TAT） 

# 代码

空间O(n)解法：

```java
class Solution {
    public int[] shuffle(int[] nums, int n) {

        int[] nums_cp = nums.clone();
        for(int i = 0; i < n; i++) {
            nums[2 * i] = nums_cp[i];
            nums[2 * i + 1] = nums_cp[n + i];
        }

        return nums;
    }
}
```

空间O(1)解法：

```java
class Solution {
    public int[] shuffle(int[] nums, int n) {

        //System.out.println( (2 | (2 << 10)) >> 10);
        for(int i = 0; i < n; i++) {
            // 取低10位里的数据存到高10位里面(低10位是原始数据)
            nums[2 * i] |= ((nums[i] & 1023) << 10);
            nums[2 * i + 1] |= ((nums[n + i] & 1023) << 10);
        }

        //  把高10位的数据替换低10位的数据
        for(int i = 0; i < nums.length; i++) nums[i] >>= 10;

        return nums;
    }
}
```

