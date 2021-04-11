<div align='center' ><font size='70'> 森林中的兔子</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/rabbits-in-forest/" target="_blank">题目链接</a>

题目描述 

森林中，每个兔子都有颜色。其中一些兔子（可能是全部）告诉你还有多少其他的兔子和自己有相同的颜色。我们将这些回答放在 answers 数组里。

返回森林中兔子的最少数量。

示例 ：

输入： answers = [1, 1, 2]

输出： 5

解释：

两只回答了 "1" 的兔子可能有相同的颜色，设为红色。

之后回答了 "2" 的兔子不会是红色，否则他们的回答会相互矛盾。
设回答了 "2" 的兔子为蓝色。

此外，森林中还应有另外 2 只蓝色兔子的回答没有包含在数组中。
因此森林中兔子的最少数量是 5: 3 只回答的和 2 只没有回答的。


# 解题思路

贪心思路：

设回答“有y只相同的兔兔”的兔兔数目为x，即可以从answers数组中统计出，有x只兔子都说"有y只兔兔和我相同颜色" (怎么跟绕口令一样~) 显然，颜色的种类越少，兔子的数量就会越少，反推一下，假如每一只兔兔都不同颜色，那么最大值为 `x * (y + 1)`

但是我们要求最小值，那就假设已经回答的兔兔中，颜色种类尽可能的少，比如有4只兔子说"有2只兔兔和我相同颜色"，不妨设第一只兔兔为红色，那么它说有两只和它颜色相同，那就假设第二只，第三只兔兔也是红色，但是第四只就不能是红色了，如果它也是红色那就和前面的话矛盾了，毕竟兔兔不会说谎~ 那第四只兔兔只能是绿色，所以最少的数量为：3只红色 + 1只绿色 + 2只绿色(这两只绿色虽然没回答但是实际存在)

可以推算出 (最小)颜色种类 `z = x % (y + 1) == 0 ? x / (y + 1) : x / (y + 1) + 1`

最小数目显然是 `z * (y + 1)`

最后把根据回答不同的y算出来的最小数目累加起来就是答案.


# 代码


```java

class Solution {
    static int maxn = 1010;
    public int numRabbits(int[] answers) {
        // same_answers_cnt[i] 代表 回答值为i的数量,即这是一个hash table
        int[] same_answers_cnt = new int[maxn];

        for(int i = 0; i <answers.length; i++) {
            same_answers_cnt[answers[i]]++;
        }

        int ans = 0;
        for(int i = 0; i < maxn; i++) {
            if(same_answers_cnt[i] != 0) {
                ans += ( same_answers_cnt[i] / (i + 1) * (i + 1));
                if(same_answers_cnt[i] % (i + 1) != 0) ans += (i + 1);
            }
        }

        return ans;

    }
}

```

