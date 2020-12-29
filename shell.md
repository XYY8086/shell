### Shell
- [菜鸟教程](https://www.runoob.com/linux/linux-shell.html)
- [Shell编程进阶](https://www.cnblogs.com/clsn/p/8028337.html)
#### 0. Shell简介
Shell种类：
- Bourne Shell(/bin/sh | /usr/bin/sh)
- Bourne Again Shell (/bin/bash)
......
**#!**告诉系统解释该脚本使用的Shell程序

Shell Script执行
- 1.作为可执行程序
`chmod +x filename.sh`:是文件具有执行权限
`./filename.sh`:在当前目录中寻找filename文件并执行  
- 2.作为解释器参数
`/bin/sh filename.sh`:此时指定解释脚本的Shell程序，就不必在Shell Script中指定了

Shell注释
- 1.单行注释'#'
- 2.多行注释
    :<<EOF
    ......
    EOF
#### 1.变量
- 定义变量
filename=test.sh
**注：等号和变量名之间不能有空格。**
- 使用变量
    ```shell
    filename=test.sh
    $filename
    ${filename}使用{}限定变量的边界
    ```
- 只读变量
readonly将变量定义为只读变量
`filename=test.sh`
`readonly filename`
- 删除变量
unset variable_name

- 字符串
    - 单引号
    单引号中的任何字符都会原样输出，变量无效
    - 双引号
    支持变量和转义符
    - 字符串拼接
        ```shell
        #!/bin/sh
        name=tom
        word=ni,hao
        p="${name} ${word}"
        echo $p
        ```
    - 获取字符串长度#
    name=tom
    echo ${#name}
    - 查找子字符串
    `expr index "$str" s`:查找str字符串中首次出现s的位置
#### 2.数组
Shell支持一维数组，不支持多维数组，下标从0开始
- 定义
array=(val0 val1)
array[0]=val0
array[1]=val1
使用空格来分割多个元素
- 读取数组
\${array[index]}
\${array[@]}: @获取所有元素
- 获取数组长度
\${#array[@]}：获取数组长度
\${#array[*]}：获取数组长度
\${#array[index]}:获取下标为index的元素的长度

#### 3.Shell传递参数

**\$n**:代表传入的第n个参数
**\$0**:代表文件名
**\$#**:传递到脚本的参数个数
**\$\***：以**单个字符串**显示所有参数
**\$@**:以每个参数作为一个元素的形式返回传入参数的集合

#### 4.Shell基本运算符
##### 4.1 算术运算符
原bash是不能直接支持数学运算的，需要借助表达式实现，如awk,expr
```shell
#/bin/sh
val=`expr 2 + 2`
echo $val
```
注意：运算符两侧必须有一个空格，斗则认为是字符串。*必须使用\*
##### 4.2 关系运算符
只支持数字，不支持字符串
-eq 相等
-ne 不相等
-gt 大于
-lt 小于
-ge 大于等于
-le 小于等于
##### 4.3 布尔运算符
！  非
-o  或
-a  与
- 逻辑运算符
&& 与
|| 或
##### 4.4 字符串运算符
=、!=   两字符串相等/不相等
-z      检测字符串长度是否为0
-n      检测字符串长度是否不为0
$       检测字符串是否为空，不为空true
##### 4.5 文件测试运算符
-b file     检测文件是否是块设备文件
-c file     检测文件是否是字符设备文件
-d file     检测文件是否是目录
-f file     检测文件是否是普通文件(既不是目录也不是设备文件)
-r/w/x file     是否可读/写/执行
-e          检测该文件(目录)是否存在
-s          检测该文件是否为空
-L          检测一个文件是否存在并且为一个符号连接
#### 5. echo | printf
##### 5.1 echo
- 显示换行
echo -e "OK \n"     **-e开启转义**
- 显示不换行
echo -e "OK \c"
- 显示命令执行结果
echo `date`

##### 5.2 printf
printf由POSIX标准所定义，移植性比echo好
语法： printf string-format [arguments...]
`printf "%-10s %-8s\n" 姓名 年纪`
%s,%d,%c,%f 都是格式替换符，-10代表输出所占的位数，-代表左补充空格

#### 6. test命令
测试某个条件是否成立，适用于数值，文件，字符。
```shell
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
EOF
if test $[num1] -eq $[num2]
then
    echo "="
else
    echo "!="
fi
```
可见test与[]几乎相同作用。注意使用if [ $con1 ]时，[]中间必须有两个空格

#### 7. 流程控制
##### 7.1 if...else...
```shell
if con1
then
    com1;
    com2;
elif con2
then
    com3;
else
    com4;
fi
```
##### 7.2 for
```shell
for var in item1 ... itemN
do
    com...
done
```
具有C语言格式的shell for循环,在循环的初始化列表中对于变量可以不使用 **\$**
```shell
n=10
for((i=0;i<n;i++)); do
    echo "$i"
done
```
##### 7.3 while
```shell
while condition
do
    command
done
```
```shell
#!/bin/sh
num1=$1
while test $((num1)) -gt 10
do
    echo $((num1))
    let "num1 = num1 - 1"
done
```
注：until循环，直到条件为真时退出循环。结构与while相同

##### 7.4 case
```shell
case valx in
val1)
    command1
    ;;
val2)
    command2
    ;;
*)
    command_else
esac
```
跳出循环：break,continue

#### 8. Shell函数
```shell
#!/bin/sh
function name () {
    echo "$1" # arguments are accessible through name, echo "$1" # arguments are accessible through , ,...,...
    return "$2"
}
name 10 300
echo $?   
```
- 函数定义
```shell
function fcnname(){
    function body
    return val
}
```
- 函数参数
$i 表示调用函数时传入的第i个参数，当i>10时 ${i}表示
- 函数调用
fcnname arg1 arg2 ...
- 函数的返回值
shell函数的返回值只能是0-255之间的整数，紧跟着使用 **$?**接收函数执行的结果

#### 9.输入输出重定向
**一般情况下，linux指令执行时会打开三个文件，标准输入文件(文件描述符为0)：STDIN，标准输出文件(文件描述符为1)：STDOUT,标准错误文件(文件描述符为2):STDERR。**
命令的执行过程：首先命令会从stdin中读入，执行之后将输出stdout中.多数情况下，默认的标准输入和输出都是终端。

| 命令      |   说明 |
| :----:    | :----: |
| command > file|输出重定向到file(覆盖)|
| command >> file|输出重定向到file(追加)|
|command < file|将输入重定向到file|
|n > file|将文件描述符为n的文件重定向到file(>>追加)|
|n >& m|将输出文件m和n合并|
|n <& m|将输入文件m和n合并|
|<<tag |将开始标记和结束标记为tag之间的内容作为输入|
注：文件描述符0:STDIN,1:STDOUT,2:STDERR.
```
----t.txt content----
hello
world
---- 1.输入重定向 ----
wc -l < t.txt
输出：2
---- 2.输入输出重定向----
wc -l <t.txt >> t.txt
将统计结果再输入到t.txt
---- 3.错误重定向----
ls | pdd 2 >> t.txt
查看t.txt:
bash: pdd: command not found
---- 4.输出和错误重定向----
wc -l t.txt >>file 2&1
将t.txt文件的统计行数写入到file文件，同时将错误信息页写入到file 
```
Here Doucument输入重定向
- 以交互式脚本形式重定向输入，交互式脚本以开始和结束标识符进行标记
    ```shell
    command <<EOF
    content...
    EOF
    #注：结尾的EOF必须顶格写，后面不能有字符(包括空格和制表)
    ```
/dev/null文件
执行某个命令，但是不显示执行结果。`command > /dev/null 2>&1`
**注意：** '2>'之间不能有空格
#### 10. 文件包含
包含外部脚本
- . filename
.和filename之间必须有一个空格
- source filename
例如：test2.sh中定义了函数name,想在test.sh中使用，`source ./test2.sh` 或是`. ./test2.sh`即可。

