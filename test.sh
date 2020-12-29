#!/bin/sh
num1=$1
num2=$2
<<EOF
if [ $num1 -eq $num2 ]
then
    echo "="
else
    echo "!="
fi

if test $[num1] -eq $[num2]
then
    echo "="
else
    echo "!="
fi
EOF
#source ./test2.sh
for i
do
    echo "$i"
done