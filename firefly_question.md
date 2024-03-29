# 问题总结

##### 1. alias取别名

利用alias取别名时，=之间不要有空格。

如：

```
alias xtark='ssh xtark@192.168.31.37'
```

##### 2. 在firefly电脑上运行无人机项目

1. 首先在工作空间下source

```bash
source devel/setup.sh
```

2. 然后运行自己的脚本
3. 最后运行multi-apm.launch

> 注意，使用launch文件的终端窗口每个都要source

##### 3.使用tqdm可以动态显示训练的进度条

```python
        for time_step in tqdm(range(self.args.time_steps)):
```



##### 4.在终端输入`top` 查看cpu使用情况

##### 5.python进行赋值时，尤其是为了保存上一状态时，注意深拷贝浅拷贝的区别，否则有可能值是一样的。

```python

Python 直接赋值、浅拷贝和深度拷贝解析

    直接赋值：其实就是对象的引用（别名）。

    浅拷贝(copy)：拷贝父对象，不会拷贝对象的内部的子对象。

    深拷贝(deepcopy)： copy 模块的 deepcopy 方法，完全拷贝了父对象及其子对象。

字典浅拷贝实例
实例
>>>a = {1: [1,2,3]}
>>> b = a.copy()
>>> a, b
({1: [1, 2, 3]}, {1: [1, 2, 3]})
>>> a[1].append(4)
>>> a, b
({1: [1, 2, 3, 4]}, {1: [1, 2, 3, 4]})

深度拷贝需要引入 copy 模块：
实例
>>>import copy
>>> c = copy.deepcopy(a)
>>> a, c
({1: [1, 2, 3, 4]}, {1: [1, 2, 3, 4]})
>>> a[1].append(5)
>>> a, c
({1: [1, 2, 3, 4, 5]}, {1: [1, 2, 3, 4]})
解析

1、b = a: 赋值引用，a 和 b 都指向同一个对象。

2、b = a.copy(): 浅拷贝, a 和 b 是一个独立的对象，但他们的子对象还是指向统一对象（是引用）。

b = copy.deepcopy(a): 深度拷贝, a 和 b 完全拷贝了父对象及其子对象，两者是完全独立的。

更多实例

以下实例是使用 copy 模块的 copy.copy（ 浅拷贝 ）和（copy.deepcopy ）:
实例
#!/usr/bin/python
# -*-coding:utf-8 -*-
 
import copy
a = [1, 2, 3, 4, ['a', 'b']] #原始对象
 
b = a                       #赋值，传对象的引用
c = copy.copy(a)            #对象拷贝，浅拷贝
d = copy.deepcopy(a)        #对象拷贝，深拷贝
 
a.append(5)                 #修改对象a
a[4].append('c')            #修改对象a中的['a', 'b']数组对象
 
print( 'a = ', a )
print( 'b = ', b )
print( 'c = ', c )
print( 'd = ', d )

以上实例执行输出结果为：

('a = ', [1, 2, 3, 4, ['a', 'b', 'c'], 5])
('b = ', [1, 2, 3, 4, ['a', 'b', 'c'], 5])
('c = ', [1, 2, 3, 4, ['a', 'b', 'c']])
('d = ', [1, 2, 3, 4, ['a', 'b']])

```

