# 基础知识学习

- [KVO](#2)
	- [KVO 的基本使用](#2.1)
	- [探究 KVO 本质](#2.2)
	- [打印 KVO 新生成类中的方法](#2.3)
	- [KVO 面试题](#2.4)
- [load、initialize](#3)
	- [load、initialize方法的区别什么？](#3.1)
	- [load、initialize的调用顺序？](#3.2)
- [Associate](#4)
	- [利用Associate为Category增加成员变量](#4.1)
- [Runtime](#7)
	- [方法交换](#7.1)
- [Runloop](#8)
	- [线程保活](#8.1)

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

<h2 id=3>load、initialize</h2>

<h3 id=3.1>load、initialize方法的区别什么？</h3>

1.调用方式

- `load`是根据函数地址直接调用
- `initialize`是通过`objc_msgSend`调用

2.调用时刻

- `load`是`runtime`加载类、分类的时候调用（只会调用`1`次）
- `initialize`是类第一次接收到消息的时候调用，每一个类只会`initialize`一次（父类的`initialize`方法可能会被调用多次）

<h3 id=3.2>load、initialize的调用顺序？</h3>

1.`load`

- 先调用类的`load`
	- 先编译的类，优先调用`load`
	- 调用子类的`load`之前，会先调用父类的`load`

- 再调用分类的`load`
	- 先编译的分类，优先调用`load`

2.`initialize`

- 先初始化父类
- 再初始化子类（可能最终调用的是父类的`initialize`方法）

<h2 id=4>Associate</h2>

<h3 id=4.1>利用Associate为Category增加成员变量</h3>

在`AssociatePerson+Category.h`中声明属性`name`

```
@property (nonatomic, copy) NSString *name;
```

在`AssociatePerson+Category.m`中重写`setName:`、`name`的方法实现

```
- (void)setName:(NSString *)name {
    
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    
    return objc_getAssociatedObject(self, _cmd);
}
```

<h2 id=7>Runtime</h2>

<h3 id=7.1>方法交换</h3>

方法交换多用于自己实现的方法和系统的方法进行交换，以便增加一些我们想在其中处理问题的方法。比如，拦截系统中`UIButton`的点击事件。

`UIButton`继承自`UIControl`，`UIControl`中有一个方法是可以拦截所有`Button`的点击事件的，如下：

```
- (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event;
```

我们就可以为`UIControl`增加一个分类，在这个分类的`load`方法里用自己的方法去替换系统的方法。

```
+ (void)load {
    
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method method2 = class_getInstanceMethod(self, @selector(qq_sendAction:to:forEvent:));
    method_exchangeImplementations(method1, method2);
}

- (void)qq_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    [self qq_sendAction:action to:target forEvent:event];
    NSLog(@"%@", self);
    NSLog(@"%@", target);
    NSLog(@"%@", NSStringFromSelector(action));
}
```

<h2 id=8>Runloop</h2>

<h3 id=8.1>线程保活</h3>

保持线程一直处于活跃状态，不必要每次执行完任务以后就被`dealloc`

```
self.thread = [[RunloopThread alloc] initWithTarget:self selector:@selector(run) object:nil];
[self.thread start];
```

```
/**
 * 线程保活
 */
- (void)run {
    
    NSLog(@"start - %s - %@", __FUNCTION__, [NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"end - %s - %@", __FUNCTION__, [NSThread currentThread]);
}
```

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

/**
 * 真正要执行的方法
 */
- (void)test {
    
    NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
}
```

但是上面那样做是会出现循环引用的，控制器和`Thread`在`pop`到之前的页面的时候也不会被销毁。明明都已经`pop`到之前的页面了，但是还是存在的。

![](https://upload-images.jianshu.io/upload_images/2069062-3ff19b46cae4ca96.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
[[NSRunLoop currentRunLoop] run];
```

上面这句代码会开启一个永远不会被销毁的线程。

重新调整代码

```
__weak typeof(self) weakSelf = self;
self.thread = [[RunloopThread alloc] initWithBlock:^{
    
    NSLog(@"start - %s - %@", __FUNCTION__, [NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    
    while (!weakSelf.isStopped) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    NSLog(@"end - %s - %@", __FUNCTION__, [NSThread currentThread]);
}];
[self.thread start];
```

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

/**
 * 真正要执行的方法
 */
- (void)test {
    
    NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
}

/**
 * button 点击方法
 */
- (void)stopThread {
    
    [self performSelector:@selector(stopSubThread) onThread:self.thread withObject:nil waitUntilDone:NO];
}

/**
 * 停止Runloop
 */
- (void)stopSubThread {
    
    self.stopped = YES;
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
}
```

这样如果点击按钮的`stopThread`方法，再`pop`到前一个控制器的时候就不会再有问题了。并且控制器和`Thread`的`dealloc`方法也会被执行。

![](https://upload-images.jianshu.io/upload_images/2069062-71393e81c50c7c76.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

但是如果不靠点击按钮执行`stopThread`方法直接`pop`到前一个控制器的时候，还是会不走`dealloc`方法，因此我们需要在控制器的`dealloc`方法里手动调用`stopThread`方法。

```
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    [self stopThread];
}
```

这样做以后，再进行测试`pop`，会发现程序直接崩溃。

![](https://upload-images.jianshu.io/upload_images/2069062-0bd6a976eba84e7e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

原因是在执行下面这句代码时，`waitUtilDone:NO`我们写的是`NO`，就代表不需要等待`stopSubThread`方法执行完毕，就进行接下来的代码的执行，但是与此同时控制器又被销毁了，而`stopSubThread`会被继续执行，这样就会造成坏内存访问。

```
/**
 * button 点击方法
 */
- (void)stopThread {
    
    [self performSelector:@selector(stopSubThread) onThread:self.thread withObject:nil waitUntilDone:NO];
}
```

解决办法就是等方法执行完以后再彻底销毁控制器。

```
[self performSelector:@selector(stopSubThread) onThread:self.thread withObject:nil waitUntilDone:YES];
```

但是你又会发现，控制器确实可以被销毁了，程序也没有崩溃了，也走了控制器的`dealloc`方法，但是`Thread`的`dealloc`方法并没有走。如下图所示：

![](https://upload-images.jianshu.io/upload_images/2069062-65821133fd760232.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

原因是在下面这句代码，控制器被销毁了，`weakSelf`就为`nil`了，就相当于`whlie(YES)`，造成`Runloop`再次被启动。

```
while (!weakSelf.isStopped) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}
```

解决办法如下

```
while (weakSelf && !weakSelf.isStopped) {
```

至此，就可以解决出现的问题了。但是当我们如果先点击`停止线程`按钮执行`stopThread`方法时，再进行`pop`操作的时候，程序又会崩溃在如下位置。当点击返回按钮时，再对已经停止`Runloop`的线程进行操作，造成了程序崩溃。

![](https://upload-images.jianshu.io/upload_images/2069062-b7203dfea6cda713.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当我们执行`stopThread`方法的时候需要对线程进行清空，然后再增加线程是否存在的逻辑判断，增加程序的严谨性。

```
/**
 * 停止Runloop
 */
- (void)stopSubThread {
    
    self.stopped = YES;
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
    
    // 清空线程
    self.thread = nil;
}
```

```
/**
 * button 点击方法
 */
- (void)stopThread {
    
    if (!self.thread) return;
    
    [self performSelector:@selector(stopSubThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}
```