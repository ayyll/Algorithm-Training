<div align='center' ><font size='70'>丑数</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/ugly-number/" target="_blank">题目链接</a>

题目描述 

给你一个整数 n ，请你判断 n 是否为 丑数 。如果是，返回 true ；否则，返回 false 。

丑数 就是只包含质因数 2、3 或/和 5 的正整数。


示例 ：


```
输入：n = 6

输出：true

解释：6 = 2 × 3

输入：n = 1

输出：true

解释：1 通常被视为丑数。
```

# 解题思路

思路比较暴力，把给定的数一直往下除2/3/5这3个数，直到除不尽为止，如果除到最后不是1，说明有非2/3/5的质因数，返回false,反之返回true,典型的深搜，不知道能不能减枝，我写的这种巨慢！ 不如叫它笨代码吧~

**注意：有一个坑点，定义丑数为正整数， 但是输入有负数，所以要开头特判一下。**

# 代码


```java
class Solution {

    static int[] arr = {2, 3, 5};
    public boolean isUgly(int n) {
        
        if(n <= 0) return false;
        return dfs(n);
    }

    boolean dfs(int n) {

        if(n == 1) return true;
        
        if(n % 2 != 0 && n % 3 != 0 && n % 5 != 0) {
            return false;
        }

        boolean ans = true;
        for(int i = 0; i < 3; i++) {
            if(n % arr[i] == 0) {
                ans = dfs(n / arr[i]);
                if(ans == false) break;
            }
        }

        return ans;
    }
}
```

