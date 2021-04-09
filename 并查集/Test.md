<div align='center' ><font size='70'>Test</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/two-sum/" target="_blank">题目链接</a>

题目描述 test two sum

示例 ：

输入：nums = [2,7,11,15], target = 9


输出：[0,1]


解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。

# 解题思路

test1

# 代码

```
public class DSU {
    int[] parent;

    public DSU(int N) {
        parent = new int[N];
        for (int i = 0; i < N; i++) {
            parent[i] = i;
        }
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        parent[find(x)] = find(y);
    }
}

```