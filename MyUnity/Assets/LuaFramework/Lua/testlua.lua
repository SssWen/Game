print("welcome to lua world");

-- 注释的诀窍
--[[
print(10000);
--]]

b = nil;
print(b);

--lua中有8中基本类型 nil boolean number string userdata function thread table
print(type("hello"));
print(type(100));
print(type(100.0));
print(type(false));
print(type(nil));

-- 因为type总是返回字符串，所有一下输出为string跟X是无关的
print(type(type(X)));

-- lua中函数是作为第一类值来看待的，可以像操作其他值一样来操作一个函数
a = print;
a(type(a));

--nil是一种类型主要用来区别其他任何值

--boolean有两个可选值 false和true lua将值false和nil视为假，而除此之外的其他值视为真，数字0和空字符串也是真

--字符串, lua的字符串和其他lua对象一样 都是自动内存管理机制所管理的对象，无需当心字符串的分配和释放， LUA可以高效的处理长字符串
--在lua中操作100K或者1M的字符串是很常见的。
a = "one string";
-- 将a中的one改为another
b = string.gsub(a, "one", "another");
print(a);
print(b);

--字面字符串需要以一对匹配的单引号或者双引号来界定
a = "a line";
b = "another line";
print("one line\nnext line\n\"in quotes\",'in quotes'");

--还可以通过数值来制定字符串中的字符，因为字符都对应一个ascii值

print("aaa");
print("\97\97\97");

-- 另外还可以用一对匹配的双方括号来界定一个字符串，就像写注释快
b = [[
	asdfasdfasd """ asdfasd ""Asdf  aa ' ' :: [===[ ===]===]--------=
]]
print(b);

--这样就可以解决在上面形式的字符串中不能有结束符]]的情况
b = [===[
	asdfasfdasdf [[]]
]===]

print(b);
-- lua提供了运行时的数字和字符串的自动转换，在字符串上应用算数操作符时候lua会尝试将这个字符串转换成一个数字
-- lua 不仅在算数操作符中会有这种强制转换，还会在其他任何需要数字的地方这么做
print("100" * "200"); -- 20000
-- ..是lua的字符串连接符 当直接在一个数字后面输入它的时候必须用一个空格来分开，不然第一个.被理解成小数点
print(type(10 .. 20)); -- string
-- 字符串传数字
b = tonumber("123456");
print(b);
-- 数字传字符串
b = tostring(123456);
print(type(b));
print(tostring(10) == "10"); -- true
print(10 .. "" == "10");	--true


--在lua5.1中可以在字符串前面放操作符“#” 来获取该字符串的长度,这个长度是实际长度不包含\0，lua中没有\0的概念
a = "hello world";
print("the length a = " .. tostring(#a));

----------------------table的使用--------------------------

--LUA可以通过table来表示普通数组，符号表，集合，记录，队列，和其他数据结构
--LUA也是通过table来表示模块（module）,包（package）， 和对象（object）
--当输入io.read的时候其含义是 io模块中的read函数
--在lua中table既不是值也不是变量 而是对象，可以将table想象成一种动态分配的对象，程序仅持有一个对他们的引用（或者指针）
--lua不会暗中生产table的副本或者创建新的table
a = {};
b = "x";
a[b] = 10;
a[20] = "great";

print(a[b]);		--10
print(a[20]);		--great

--table永远是匿名的，一个持有table的变量与table自身之间没有固定的关联性

a = nil;
b = nil;
a = {};
a["x"] = 100;
b = a;
print(b["x"]); --100
b[200] = 300;
print(a[200]); --300

-- 所有的table都可以用不同类型来索引访问value值，当需要容纳新条目，table会自扩展

--lua对于诸如a["name"]的写法提供了一种更简单的语法糖，可以直接输入a.name因此
a.x = 10; --a["x"] = 10'
print(a.x);

--点的写法明确的按时了读者将table作为一条记录来使用，每组记录都有一个固定的， 预定义的key，而字符串的写法
--暗示了该table会以任何字符串作为key

--初学者常将a.x和a[x]搞错 a.x 等同于 a["x"] 而 a[x]表示以x的值为key来索引table
a = {};
x = "y";
a[x] = 10;  ---a["y"]
print(a[x]); --10
print(a.x); --nil "x"未定义
print(a.y); --10 等同 a[“y”]

-- table作为vector
a = {};

for i=0,100 do
	a[i] = i;
end

for i=0, 100 do
	print(a[i]);
end

--#用于返回一个数组或者线性表最后一个索引值
print(a[#a]); --100 打印最后一个值
a[#a] = nil; --删除最后一个值
a[#a+1] = 200; --200添加到表末尾key为#a+1；
a[122] = 136;
--table.maxn返回最大数字key
print(table.maxn(a));


-----------------lua的function----------------
--在lua中function被作为第一类值来看待，这表示函数可以存储在变量中，可以通过参数传递给其他函数，还可以作为函数的返回值
--lua可以调用自身lua语言编写的函数，又可以调用以c语言编写的函数
-- ^(指数) X^0.5 计算x的平方根
-- %取模

x = math.pi; --3.14159
--对于实数而言x%1的结果就是x的小数部分 X%0.01则是精确到小数点后两位的结果
print(x % 0.01);--0.00159
print(x- x%0.01); --3.14

-- ~= 为不相等测试 ==为相等性测试 如果对于两个不同类型lua认为他们是不相等的，否则lua会根据他们的类型
-- 来比较两者，对于table userdata和函数 lua则是作引用比较。
-- 逻辑运算符 and or not，所有逻辑操作符将false和nil视为假。而将其他的任何东西视为真

-- and操作符如果第一个操作数为假，就返回第一个操作数，不然返回第二个操作数
-- or操作符如果它的第一个操作数为真就返回第一个操作数，不然返回第二个操作数

-- and和or都是使用短路求值，也就是有需要的时候才去评估第二个操作数
x = 10;
v = 20;
x = x or v; --可以用在没有设置x的时候给x设置一个默认的v值
print(x);
x = false;
x = x or v;
print(x); 

-- (a and b) or c 类似于c语言中的表达式 a？b：c

-------------------------------table构造式----------------------

--这样访问table的下表默认从1开始
a = {"1", "2", "3", "4"};
for i=1, #a do
	print(a[i]);
end

print("----------------------------------------------------");
a = nil;

--初学者常将a.x和a[x]搞错 a.x 等同于 a["x"] 而 a[x]表示以x的值为key来索引table
a = {x=10, y=20}; -- 等同 a={}; a.x=10; a.y=20
print(a["x"]);

print("----------------------------------------------------");
a = nil;
a = {
color="blue", thickness=2, npoints=4, ---记录风格table属于a
{x=100,y=200},							  ---列表风格table属于a[1]
{x=-10, y=0},						  ---列表风格table属于a[2]
{x=-10, y =1},						  ---列表风格table属于a[3]
{x=0, y=1}							  ---列表风格table属于a[4]
};

print(a["color"]);
print(a["npoints"]);

print(a[1].x);
print(a[2].x);
print(a[4].y);

-- 上述记录分隔和列表分隔的构造式有其限制，例如不能使用负数的索引，也不能用运算符作为记录的字段名，
--为了满足这一需求Lua提供了更通用的格式这种格式允许在方括号之间显示的用一个表达式来初始化索引

print("==============================================================");
a = nil;
a = {["+"] = "add", ["-"] = "sub", ["*"] = "mul", ["/"]="div"};
i=20;
s="-";
a = nil;
a = {[i+0]=s, [i+1] = s..s, [i+2] = s..s..s};

print("==============================================================");
--赋值
a = nil;
b = nil;
a,b = 10, 20;
print(a..b);

--在多重赋值中lua先对等号右边的所有元素求值，然后才执行赋值
--lua总是将等号右边的个数调整到与左边变量的个数相一致
a,b = b,a;
print(a..b);

----------------------------------局部变量和块------------------
--一个块是一个控制结构的执行体，或者是一个函数的执行体，或者是一个程序块。
--在lua的交互模式下每行输入内容自身就形成一个程序块，一旦输入local i= 1； lua马上就运行这句话
--并且为下一行的运行开启一个新程序块，到那时local i 的声明就超出了其作用于。为了解决这个问题，可以显示的
--界定一个块，只需要将内容放入一对关键字 do-end中即可。

-------------------------------条件控制---------
print("=======================条件控制================================");
a = nil;
b = nil;
a = 10;
b = 2;
if a < 0 then 
a = 0;
print(a);
end;

if a < b then
	--return a; --这边被返回
else
	--return b; --这边被返回
end

if a == 0 then
elseif a == 1 then
elseif a == 2 then	
end

--LUA不支持switch所以一连串if else if 的代码是很常见的

--while lua先测试while的条件，如果条件为假，那么循环结束，不然lua执行循环体，并重复这一过程
a = 20;
while a > 0 do
	print(a);
	a  = a -1;
end

--repeat 一条repeat-until语句重复执行循环体知道条件为真时候结束

repeat
	a = a + 20;
until a > 200

--for有两种类型 数字型和泛型


-- 1,3,5,7,9
for a = 1, 10, 2 do
	print(a);
end

--第三个参数是可选的，如果不置顶lua会将步长默认为1

for a = 10, 1, -1 do
	print(a);
end

--如果不想设置上限值可以使用常亮 math.huge
for a = 0, math.huge do
	
	print(a);
	if (a > 10) then
		break;
	end
end

--for的三个表达式是在循环开始前一次性求值的。
--由于词法构造的原因 break和return 只能是一个块的最后一条语句，
--换句话说他们是程序的最后一条语句，或者是end else until前的一条语句
--有时候希望在块的中间插入一个return或者break要使用do  end来包住return语句
--这样运行会报错
--[[function foo()
	return;
	a = 100;
end--]]

--中间插入用do end包住return
function foo()
	do return end;
	a = 100;
end

print("=======================LUA函数================================");

--函数都需要将参数放到一个圆括号中，即使调用函数没有参数也要写，有一种特殊情况
--函数只有一个参数并且此参数是一个字面字符串或者table的构造式，那么圆括号可有可无。

print "hello function";
--lua为面向对象提供了一种特殊的y7ufa--冒号操作符。表达式 o.foo(o.x)的另一种写法O:foo(x),冒号操作符隐藏的将o作为第一个函数的参数
--实参和形参 实参多余形参则舍弃多余的实参，如果实参不足则多余的形参初始化为nil
count = 0;
function incCount(n)
	n = n or 1;
	count = count + n;
	return count;
end

a = nil;
a = incCount();
print("incCount" .. a);

--lua会调整一个函数的返回值以适应不同的调用情况
--当一个函数调用作为另一个函数的最后一个参数实参时 第一个函数所有的返回值都将最为实参传入
function foo2()
	return 1,2;
end
print(foo2()); --1,2
print(foo2(), 3); --1,3;


--return 语句后面的内容不需要圆括号 在该位置写圆括号会导致不同的行为
--return(f(x))将只返回一个值。无关乎f返回几个值

--关于多重返回值有一个特殊函数 unpack 它接受一个数组作为参数，并从下表1开始返回数组的所有元素
print(unpack{10,20,30}); -- 10,20,30
--变成参数

function add(...)
	for i,v in ipairs(...) do
		--i是下标 v是值
		print("value="..v);
	end
end
--add(10,20,30,nil,50); 因为有nil所以lua会报错
--   ~=是不等
function printarray(...)
	for i=1, select('#', ...) do
		local arg = select(i, ...);
		if nil ~= arg then
			print("arg" .. arg);
		end
		
	end
end

printarray(10,20,50,nil, 60);


print("=======================LUA深入函数================================");
--词法域是指一个函数可以嵌套在另一个函数中，内部函数可以访问外部函数的变量。
--将函数存储在table的字段中可以支持许多lua的高级应用，例如模块和面向对象编程

function newCounter() 
	local i = 0;
	i = i + 1;
	return i;
end

c1 = newCounter;
print("1 = " .. c1());
print("2 = " .. c1());

--closure 是指一个函数以及一系列这个函数会访问到的“非局部的变量（upvalue）” 因此如果一个closure没有那些
--会访问到的“非局部变量” 那它就是一个传统概念中的函数

