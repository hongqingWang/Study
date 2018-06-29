# 基础知识学习

- [KVO](#2)
	- [KVO 的基本使用](#2.1)
	- [探究 KVO 本质](#2.2)
	- [打印 KVO 新生成类中的方法](#2.3)
	- [KVO 面试题](#2.4)

<h2 id=2>KVO</h2>

<h3 id=2.1>KVO 的基本使用</h3>

监听一个`Person`类的`age`属性的变化

```
NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
[self.person addObserver:self forKeyPath:@"age" options:options context:nil];
```

点击屏幕改变属性`age`的值

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.person.age = 10;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"keyPath = %@", keyPath);
    NSLog(@"change = %@", change);
    NSLog(@"context = %@", context);
}
```

输出

```
keyPath = age
change = {
    kind = 1;
    new = 10;
    old = 1;
}
context = (null)
```

<h3 id=2.2>探究 KVO 本质</h3>

为了增强对比性，我们这里再增加一个不被监听的`person2`对象来做对比。

```
self.person1 = [[Person alloc] init];
self.person1.age = 1;

self.person2 = [[Person alloc] init];
self.person2.age = 2;

NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
[self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
```

再改变值的点击事件位置处增加断点，查看两个对象的`isa`。

```
(lldb) p self.person1->isa
(Class) $1 = NSKVONotifying_Person
```

```
(lldb) p self.person2->isa
(Class) $2 = Person
```

可以发现两个`isa`指向不同的类。`person1`被监听，所以运行时动态生成了一个`NSKVONotifying_Person`的类。再这个新生成的类里，有这个类自己的`- (void)setAge:(int)age`方法的实现，以下代码仅是猜想！！！

```
- (void)setAge:(int)age {
    _NSSetIntValueAndNotify();
}

void _NSSetIntValueAndNotify() {
    
    [self willChangeValueForKey:@"age"];
    [super setAge:age];
    [self didChangeValueForKey:@"age"];
}

- (void)didChangeValueForKey:(NSString *)key {
    
    // 通知监听器，某某属性值发生了改变
    [oberser observeValueForKeyPath:key ofObject:self change:nil context:nil];
}
```

利用`object_getClass(id  _Nullable obj)`函数查看`person1`监听前后所属类的变化。验证`person1`监听之后就属于`NSKVONotifying_Person`类。

```
NSLog(@"person1 监听之前 - %@, %@", object_getClass(self.person1), object_getClass(self.person2));

NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
[self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];

NSLog(@"person1 监听之后 - %@, %@", object_getClass(self.person1), object_getClass(self.person2));
```

```
person1 监听之前 - Person, Person
person1 监听之后 - NSKVONotifying_Person, Person
```

利用`methodForSelector:(SEL)`函数查看`person1`被监听前后`setAge:`地址的变化证明被监听后是有新的方法生成。

```
NSLog(@"person1 监听之前 - %p, %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);

NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
[self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];

NSLog(@"person1 监听之后 - %p, %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);
```

```
person1 监听之前 - 0x10abbb140, 0x10abbb140
person1 监听之后 - 0x10af64f8e, 0x10abbb140
```

用`lldb`根据`methodForSelector:(SEL)`方法打印出的地址，查看对应的函数方法。

监听之前`person1`、`person2`和未被监听的`person2`的`setAge:`方法的地址打印输出的方法如下:

```
(lldb) p (IMP)0x10ef36140
(IMP) $1 = 0x000000010ef36140 (Study`-[Person setAge:] at Person.h:13)
```

被监听后`person1`的`setAge:`方法的地址打印输出的方法如下:

```
(lldb) p (IMP)0x10f2dff8e
(IMP) $2 = 0x000000010f2dff8e (Foundation`_NSSetIntValueAndNotify)
```

由此验证之前的猜想。

```
- (void)setAge:(int)age {
    _NSSetIntValueAndNotify();
}
```

<h3 id=2.3>打印 KVO 新生成类中的方法</h3>

利用运行时`class_copyMethodList()`方法，获取类中的方法列表，输出。

```
- (void)printMethodNamesOfClass:(Class)cls {
    
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    
    NSMutableArray *methodArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [methodArray addObject:methodName];
    }
    
    free(methodList);
    
    NSLog(@"%@ - %@", cls, methodArray);
}
```

```
[self printMethodNamesOfClass:object_getClass(self.person1)];
[self printMethodNamesOfClass:object_getClass(self.person2)];
```

```
NSKVONotifying_Person - (
    "setAge:",
    class,
    dealloc,
    "_isKVOA"
)
Person - (
"setAge:",
age
)
```

由此看出`NSKVONotifying_Person`类中的方法有`setAge:`、`class`、`dealloc`、`_isKVOA`。

<h3 id=2.4>KVO 面试题</h3>

1. KVO 的本质是什么？

- 利用`RuntimeAPI`动态生成一个子类，并且让`instance`对象的`isa`指向这个全新的子类
- 当修改`instance`对象的属性时，会调用`Foundation`的` _NSSetxxxValueAndNotify`函数
	- `willChangeValueForKey:`
	- `[super setter]`
	- `didChangeValueForKey:`
- 内部会触发监听器`(Observer)`的监听方法`(observeValueForKeyPath: ofObject: change: context:)`

2. 如何手动触发 KVO?

- 手动调用如下方法
	- `willChangeValueForKey`
	- `didChangeValueForKey`