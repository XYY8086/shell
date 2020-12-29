#!/bin/sh
# work 1   for循环，输出当前文件夹下的所有文件和目录
#for i in `pwd | ls`
for i in $(pwd | ls)
do
    echo $i
done