<div align='center' ><font size='70'>实现 strStr</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/implement-strstr/">题目链接</a>

题目描述 :

实现 strStr() 函数。

给你两个字符串 haystack 和 needle ，请你在 haystack 字符串中找出 needle 字符串出现的第一个位置（下标从 0 开始）。如果不存在，则返回  -1 。

说明：

当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。

对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与 C 语言的 strstr() 以及 Java 的 indexOf() 定义相符。

````
示例 1：
输入：haystack = "hello", needle = "ll"
输出：2

示例 2：
输入：haystack = "aaaaa", needle = "bba"
输出：-1

示例 3：
输入：haystack = "", needle = ""
输出：0
````

# 解题思路

遍历其中一个字符串，将各个字符依次和另一个字符串的对应字符进行比对，一旦发现有字符不一样，立刻移动第一个字符串的子串起始位置。

如果能够遍历完第二个字符串，说明找到了相同的子串。

# 代码

```java
class Solution {
    public int strStr(String haystack, String needle) {
        int m = haystack.length();
        int n = needle.length();
        if (n == 0) {
            return 0;
        }
        for (int i = 0; i <= m - n; i++) {
            for (int j = 0; j <= n - 1; j++) {
                if (haystack.charAt(i + j) != needle.charAt(j)) {
                    break;
                }
                if (j == n - 1) {
                    return i;
                }
            }
        }
        return -1;
    }
}
```

