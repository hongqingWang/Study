//
//  KVOPrintMethodClassNameViewController.m
//  Study
//
//  Created by 王红庆 on 2018/6/30.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "KVOPrintMethodClassNameViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface KVOPrintMethodClassNameViewController ()

@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;

@end

@implementation KVOPrintMethodClassNameViewController

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

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.person1 = [[Person alloc] init];
    self.person1.age = 1;
    
    self.person2 = [[Person alloc] init];
    self.person2.age = 2;
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];
    /*
     NSKVONotifying_Person - (
     "setAge:",
     class,
     dealloc,
     "_isKVOA"
     )
     */
    [self printMethodNamesOfClass:object_getClass(self.person1)];
    
    /*
     Person - (
     "setAge:",
     age
     )
     */
    [self printMethodNamesOfClass:object_getClass(self.person2)];
}

- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
}

#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.person1.age = 10;
    self.person2.age = 20;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"keyPath = %@", keyPath);
    NSLog(@"change = %@", change);
    NSLog(@"context = %@", context);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"直接看控制台";
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.frame = self.view.bounds;
}

@end
