<div align='center' ><font size='70'>第十行</font></div>

# 题目描述

<a href="https://leetcode-cn.com/problems/tenth-line/" target="_blank">题目链接</a>

题目描述 

给定一个文本文件 file.txt，请只打印这个文件中的第十行。

示例 ：

假设 file.txt 有如下内容：

```

Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
```

你的脚本应当显示第十行：

```
Line 10
```

# 解题思路

基础的bash语法，熟悉一下，主要用到： 变量定义--变量取值--变量比较--for循环--if语句--break语句--管道符--等


# 代码


```shell

# Read from the file file.txt and output the tenth line to stdout.

# ------------read釜底抽薪法----------------
#!/bin/bash
cnt=0
ten=10
while read line; do
    let cnt+=1

    if [ $cnt -eq $ten ];then
        echo $line
        break
    fi
done < file.txt

#------------- End -------------------------

# ------------管道重定向法----------------
#!/bin/bash
cnt=0
ten=10

cat file.txt | while read line; do
    let cnt+=1
    if [ $cnt -eq $ten ];then
        echo $line
        break
    fi
done
#------------- End -------------------------

```

