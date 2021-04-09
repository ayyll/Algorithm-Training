<div align='center' ><font size='70'>岛屿数量</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/number-of-islands/">题目链接</a>

题目描述 :

给你一个由 '1'（陆地）和 '0'（水）组成的的二维网格，请你计算网格中岛屿的数量。

岛屿总是被水包围，并且每座岛屿只能由水平方向和/或竖直方向上相邻的陆地连接形成。

此外，你可以假设该网格的四条边均被水包围。

示例 1：

输入：grid = [

["1","1","1","1","0"],

["1","1","0","1","0"],

["1","1","0","0","0"],

["0","0","0","0","0"]

]

输出：1

示例 2：

输入：grid = [

["1","1","0","0","0"],

["1","1","0","0","0"],

["0","0","1","0","0"],

["0","0","0","1","1"]

]

输出：3

# 解题思路

建立大小为m*n的并查集，其中m为网格的行数，n为网格的列数。

遍历网格，如果是'1'表明这是一块陆地，遍历它的上下左右，如果越界或者邻接的是水，那么就跳过这个方向。

对于邻接是陆地的情况，就将当前陆地和对应方向陆地进行合并。这里合并的方式是将二维的表示方式转换成一维的表示方式。

合并完成以后，再次遍历网格，当遇到'1'时，去进行判断，当前是否为一个集合的根，如果是，就对岛屿数量加一。遍历完成，返回最终的岛屿数量。

# 代码

```
class Solution {
    public int numIslands(char[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        DSU dsu = new DSU(m * n);
        int[][] dirs = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        int count = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '1') {
                    for (int[] dir : dirs) {
                        int x = dir[0] + i;
                        int y = dir[1] + j;
                        if (x < 0 || x >= m || y < 0 || y >= n || grid[x][y] == '0') {
                            continue;
                        }
                        dsu.union(x * n + y, i * n + j);
                    }
                }
            }
        }
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '1' && dsu.find(i * n + j) == i * n + j) {
                    count++;
                }
            }
        }
        return count;
    }
}

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

