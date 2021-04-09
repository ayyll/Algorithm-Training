#!/bin/bash

cat_array=("水题" "递推" "模拟" "贪心" "枚举" "哈希" "DP" "二分" "搜索" "数学" "并查集" "栈" "堆" "队列" "链表" "树" "图")

for(( i=0;i<${#cat_array[@]};i++)) do
#${#cat_array[@]}获取数组长度用于循环
#echo ${cat_array[i]};
mkdir ./${cat_array[i]}
cp ../README.md ./${cat_array[i]}/
done;