
set -x   #提供执行信息,将执行的每一条命令和结果依次打印出来

cd `dirname $0` || exit

echo `dirname $0` 

#变量学习
name="Jack"
s="$name, hello!" #注意等号"="前后都不能有空格。建议字符串用双引号（单引号表示纯字符串，不支持$等）。
echo $s           #输出Jack, hello!（若s用单引号，则输出$name, hello!）
unset s           #删除变量s

s="./*"
echo $s     #这是变量，命令即为echo ./* ,通配符解开为:./1.sh ./a ./b ./c
echo '$s'   #这里的单引号表示一个字符串，字符串中的$等符号不能转义，输出：$s
echo "$s"   #这里的双引号表示一个字符串，字符串中的$等符号要转义，其中$s为变量，所以输出./*

