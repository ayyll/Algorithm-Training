<div align='center' ><font size='70'>最长连续序列</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/longest-consecutive-sequence/">题目链接</a>

题目描述 :

给定一个未排序的整数数组 nums ，找出数字连续的最长序列（不要求序列元素在原数组中连续）的长度。

进阶：你可以设计并实现时间复杂度为 O(n) 的解决方案吗？

```
示例 1：

输入：nums = [100,4,200,1,3,2]

输出：4

解释：最长数字连续序列是 [1, 2, 3, 4]。它的长度为 4。

示例 2：

输入：nums = [0,3,7,2,5,8,4,6,0,1]

输出：9
```
# 解题思路

题目要求时间复杂度是O(n)，遍历一次数组得出结果。这里提供一个并查集的思路。

首先建立一个哈希表，key为元素值，value为元素在数组中的位置下标；遍历数组，判断当前元素是否在哈希表中，如果已经存在（说明重复了），直接跳过这个元素。否则，就把它和它的下标存入哈希表中。

然后分别去判断，这个元素x的邻接元素（x-1和x+1）是否在哈希表中，如果在的话，就将当前元素的下标和邻接元素的下标在并查集中进行合并。

解题的关键在于，对于一个已经存在的连续序列，比如6、7、8、9，假设我们先遍历到的是8，那么哪怕此时哈希表中暂时还没有7，无法进行向左的合并，但是等到我们遍历到7的时候，就可以将7向右和8合并；同理，哪怕此时哈希表中暂时还没有9，我们无法向右进行合并，但是等到我们遍历到9的时候，可以向左对8进行合并。

对于一个数x来讲，如果此时无法向右和x+1进行合并（假设x+1存在），也不着急，因为在未来的某个时候，x+1一定会向左去和x进行合并。有点啰嗦，总之就是这个意思，最后，连续的序列一定会合并到同一个集合中。

并查集模版的选择：因为我们要求的是最长连续序列的长度，即一个个合并了的集合中，集合里面包含元素数目最多的情况，所以选择用size进行优化的方式。把元素数较小的集合往元素数较大的集合去靠，在每一次合并时就去维护集合元素的数目。



# 代码


```java
class Solution {
    public int longestConsecutive(int[] nums) {
        int n = nums.length;
        DSUWithSize dsu = new DSUWithSize(n);
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            if (map.containsKey(nums[i])) {
                continue;
            }
            map.put(nums[i], i);
            if (map.containsKey(nums[i] + 1)) {
                dsu.union(i, map.get(nums[i] + 1));
            }
            if (map.containsKey(nums[i] - 1)) {
                dsu.union(i, map.get(nums[i] - 1));
            }
        }
        return dsu.getMaxSize();
    }
}

class DSUWithSize {
    int[] parent;
    int[] size;

    public DSUWithSize(int N) {
        parent = new int[N];
        size = new int[N];
        for (int i = 0; i < N; i++) {
            parent[i] = i;
        }
        Arrays.fill(size, 1);
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX == rootY) {
            return;
        }
        if (size[rootX] < size[rootY]) {
            parent[rootX] = rootY;
            size[rootY] = size[rootY] + size[rootX];
        } else {
            parent[rootY] = rootX;
            size[rootX] = size[rootX] + size[rootY];
        }
    }

    public int getMaxSize() {
        int max = 0;
        for (int i = 0; i < size.length; i++) {
            max = Math.max(max, size[i]);
        }
        return max;
    }
}
```

