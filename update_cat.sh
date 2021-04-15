#!/bin/bash

dir=$(ls -l ./ |awk '/^d/ {print $NF}')
for i in $dir;do
    # 先清空目录
    : > ./$i/README.md 
    for file in $(ls $i);do
        if [ "${file##*.}"x = "md"x ]&&[ "${file%.*}"x != "README"x ];then
            #echo $file
            first_line=$(sed -n '1p' $i/$file)
            
            # 字符串截取
            first_line=${first_line#*>}
            first_line=${first_line#*>}
            first_line=${first_line%<*}
            first_line=${first_line%<*}

            #echo $file
            #echo $first_line
            #重建目录
            cat_line="["$first_line"]("$file")\n";
            #echo $cat_line
            echo -e $cat_line >> ./$i/README.md
        fi
    done  
done