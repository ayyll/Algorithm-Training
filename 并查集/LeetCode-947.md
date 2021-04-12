<div align='center' ><font size='70'>移除最多的同行或同列石头</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/most-stones-removed-with-same-row-or-column/">题目链接</a>

题目描述 :

n 块石头放置在二维平面中的一些整数坐标点上。每个坐标点上最多只能有一块石头。

如果一块石头的 同行或者同列 上有其他石头存在，那么就可以移除这块石头。

给你一个长度为 n 的数组 stones ，其中 stones[i] = [xi, yi] 表示第 i 块石头的位置，返回 可以移除的石子 的最大数量。


```
示例 1：

输入：stones = [[0,0],[0,1],[1,0],[1,2],[2,1],[2,2]]
输出：5
解释：一种移除 5 块石头的方法如下所示：
1. 移除石头 [2,2] ，因为它和 [2,1] 同行。
2. 移除石头 [2,1] ，因为它和 [0,1] 同列。
3. 移除石头 [1,2] ，因为它和 [1,0] 同行。
4. 移除石头 [1,0] ，因为它和 [0,0] 同列。
5. 移除石头 [0,1] ，因为它和 [0,0] 同行。
石头 [0,0] 不能移除，因为它没有与另一块石头同行/列。


示例 2：

输入：stones = [[0,0],[0,2],[1,1],[2,0],[2,2]]
输出：3
解释：一种移除 3 块石头的方法如下所示：
1. 移除石头 [2,2] ，因为它和 [2,0] 同行。
2. 移除石头 [2,0] ，因为它和 [0,0] 同列。
3. 移除石头 [0,2] ，因为它和 [0,0] 同行。
石头 [0,0] 和 [1,1] 不能移除，因为它们没有与另一块石头同行/列。

示例 3：

输入：stones = [[0,0]]
输出：0
解释：[0,0] 是平面上唯一一块石头，所以不可以移除它。
```
# 解题思路

为了理解题目最好先对照1个示例画图，模拟一遍就很清楚了。

我自己最开始的想法是，从第一块石头开始，尽可能地去选择和它不是同行或者同列的石头，然后数一数最后得到了几块石头，总数减去这个数字就是结果。

以示例1为例，选择 [0,0] 以后，就不选 [0,1] , [1,0] 了，然后可以选 [1,2] 和 [2,1] ,最后不选 [2,2]。这样得到的序列包含3块石头，也就是说可以移除（6-3）=3块，显然不是想要的答案。

所以其实应该反过来想，去选择石头的时候，不是避开那些同行或者同列的石头，而是尽量去选择那些石头，放到一个集合里面（这个集合里面的石头多多少少有点关系），还是示例1为例，按照这个思路就可以把6块石头全都关联起来，放进一个集合，那么倒推，一定可以按照某种路径消啊消，最后消到只剩一块石头。

一个集合最后可以消成一块石头——利用并查集。

实际写代码，我用了两个哈希表，分别是 行-某个石头代表元；列-某个石头代表元；然后利用并查集去合并。




# 代码


```java
class Solution {
    public int removeStones(int[][] stones) {
        int n = stones.length;
        DSU dsu = new DSU(n);
        Map<Integer, Integer> rowToIndex = new HashMap<>();
        Map<Integer, Integer> colToIndex = new HashMap<>();
        for (int i = 0; i < n; i++) {
            if (!rowToIndex.containsKey(stones[i][0])) {
                rowToIndex.put(stones[i][0], i);
            } else {
                dsu.union(rowToIndex.get(stones[i][0]), i);
            }
            if (!colToIndex.containsKey(stones[i][1])) {
                colToIndex.put(stones[i][1], i);
            } else {
                dsu.union(colToIndex.get(stones[i][1]), i);
            }
        }
        return n - dsu.numOfUnion();
    }
}

class DSU {
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

    public boolean isConnected(int x, int y) {
        return find(x) == find(y);
    }

    public int numOfUnion() {
        int num = 0;
        for (int i = 0; i < parent.length; i++) {
            if (parent[i] == i) {
                num++;
            }
        }
        return num;
    }
}
```

