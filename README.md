# principle_of_compiling
华中科技大学2021级大三编译原理实验

# flex&bison入门
 对.l文件执行命令
~~~
flex task.l
~~~
执行后会生成一个lex.yy.c文件

对该文件执行命令
~~~
gcc -o output lex.yy.c -ll
~~~
生成一个output.exe的可执行文件，执行以下命令即可运行
~~~
./output    //直接运行
./output<text.txt    //输入txt文件中的信息
~~~
