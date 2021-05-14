<div align='center' ><font size='70'>无法吃午餐的学生数量</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/number-of-students-unable-to-eat-lunch/" target="_blank">题目链接</a>

题目描述
学校的自助午餐提供圆形和方形的三明治，分别用数字 0 和 1 表示。所有学生站在一个队列里，每个学生要么喜欢圆形的要么喜欢方形的。
餐厅里三明治的数量与学生的数量相同。所有三明治都放在一个 栈 里，每一轮：

- 如果队列最前面的学生 喜欢 栈顶的三明治，那么会 拿走它 并离开队列。

- 否则，这名学生会 放弃这个三明治 并回到队列的尾部。

这个过程会一直持续到队列里所有学生都不喜欢栈顶的三明治为止。

给你两个整数数组 students 和 sandwiches ，其中 sandwiches[i] 是栈里面第 i​​​​​​ 个三明治的类型（i = 0 是栈的顶部）， students[j] 是初始队列里第 j​​​​​​ 名学生对三明治的喜好（j = 0 是队列的最开始位置）。请你返回无法吃午餐的学生数量。

示例 ：

```
输入：students = [1,1,0,0], sandwiches = [0,1,0,1]
输出：0 
解释：
- 最前面的学生放弃最顶上的三明治，并回到队列的末尾，学生队列变为 students = [1,0,0,1]。
- 最前面的学生放弃最顶上的三明治，并回到队列的末尾，学生队列变为 students = [0,0,1,1]。
- 最前面的学生拿走最顶上的三明治，剩余学生队列为 students = [0,1,1]，三明治栈为 sandwiches = [1,0,1]。
- 最前面的学生放弃最顶上的三明治，并回到队列的末尾，学生队列变为 students = [1,1,0]。
- 最前面的学生拿走最顶上的三明治，剩余学生队列为 students = [1,0]，三明治栈为 sandwiches = [0,1]。
- 最前面的学生放弃最顶上的三明治，并回到队列的末尾，学生队列变为 students = [0,1]。
- 最前面的学生拿走最顶上的三明治，剩余学生队列为 students = [1]，三明治栈为 sandwiches = [1]。
- 最前面的学生拿走最顶上的三明治，剩余学生队列为 students = []，三明治栈为 sandwiches = []。
所以所有学生都有三明治吃。
```

# 解题思路

很有意思的题，一开始想着队列和栈都模拟，后来发现循环队列写起来太麻烦，再想一下，其实队列操作根本不用管，因为学生是可以无限循环排队的，所以不用理会队列，**考虑食物(栈),对于当前栈顶的食物，只要队列中还有喜欢吃该食物的人，那么该食物必然会被消费掉。当栈空的时候，或者栈顶的食物在队列中找不到爱吃它的人时，退出模拟。**

注意，我们需要两个计数变量来统计一下爱吃0的人和爱吃1的人。

# 代码


```java
class Solution {
    public int countStudents(int[] students, int[] sandwiches) {

        int stu_one_cnt = 0; // 爱吃1的学生个数
        int stu_zero_cnt = 0; // 爱吃0的学生个数
        for(int i = 0; i < students.length; i++) {
            if(students[i] == 1) stu_one_cnt++; 
        }
        stu_zero_cnt = students.length - stu_one_cnt;

        //int head = 0, tail = students.length;
        // 让食物去匹配学生，队列操作不用管，比如栈顶是1 只要队列中还有爱吃的1的人，必定能把这个1消费掉
        int top = 0;
        while(top < sandwiches.length) {
            
            // 当栈顶的食物 没有相应的人可以消费的时候，此时代表匹配结束，退出即可
            if((sandwiches[top] == 0 && stu_zero_cnt == 0) || (sandwiches[top] == 1 && stu_one_cnt == 0)) {
                break;
            }
            // 0被吃，栈顶移动，队列中爱吃0的人数减1
            if(sandwiches[top] == 0 && stu_zero_cnt != 0) {
                top++;
                stu_zero_cnt--;
            } else if(sandwiches[top] == 1 && stu_one_cnt != 0) { // 同上
                top++;
                stu_one_cnt--;
            }
 
        }

        return stu_zero_cnt + stu_one_cnt;
    }
}
```

