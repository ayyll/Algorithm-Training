<div align='center' ><font size='70'>笨阶乘</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/clumsy-factorial/" target="_blank">题目链接</a>

题目描述

通常，正整数 n 的阶乘是所有小于或等于 n 的正整数的乘积。例如，factorial(10) = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1。

相反，我们设计了一个笨阶乘 clumsy：在整数的递减序列中，我们以一个固定顺序的操作符序列来依次替换原有的乘法操作符：乘法(*)，除法(/)，加法(+)和减法(-)。

例如，clumsy(10) = 10 * 9 / 8 + 7 - 6 * 5 / 4 + 3 - 2 * 1。然而，这些运算仍然使用通常的算术运算顺序：我们在任何加、减步骤之前执行所有的乘法和除法步骤，并且按从左到右处理乘法和除法步骤。

另外，我们使用的除法是地板除法（floor division），所以 10 * 9 / 8 等于 11。这保证结果是一个整数。

实现上面定义的笨函数：给定一个整数 N，它返回 N 的笨阶乘。

示例 ：


```

输入： 10

输出： 12

解释： 12 = 10 * 9 / 8 + 7 - 6 * 5 / 4 + 3 - 2 * 1

```


# 解题思路

遇到乘除直接算，遇到加减先入栈~

最后栈里面的元素从底至上依次为 x + y - z + ...
 
可以看到是奇加偶减(下标从0开始) 处理一下就是结果。

# 代码


```java

class Solution {

    public int clumsy(int N) {
        Stack<Integer> st = new Stack<Integer>();
        
        int op = 0; // 操作符 0:乘 1:除 2:加 3:减
        int tem_res = N; //暂存乘除运算的结果值
        for(int i = N; i >= 1; i--,op++) {
            //防止除0 直接入栈break           
            if(i == 1) {
                st.push(tem_res);
                break;
            }
            //乘除直接算，加减先入栈
            switch(op % 4) {
                case 0: tem_res *= (i - 1);break;
                case 1: tem_res /= (i - 1);break;
                default: { st.push(tem_res);tem_res = i - 1; }
            }
        }

        Integer[] st_arr = st.toArray(new Integer[st.size()]);
        int ans = st_arr[0];
        // 把栈转成数组方便处理，奇加偶减
        for(int i = 1; i < st_arr.length; i++) {
            if(i % 2 == 1) ans += st_arr[i];
            else ans -= st_arr[i]; 
        }

        return ans;
    }
}

```

