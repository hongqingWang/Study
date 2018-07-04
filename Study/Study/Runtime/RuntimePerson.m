//
//  RuntimePerson.m
//  Study
//
//  Created by 王红庆 on 2018/7/4.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimePerson.h"
#import <objc/runtime.h>

@implementation RuntimePerson

- (void)dynamicAddInstanceMethod {
    
    NSLog(@"%s", __FUNCTION__);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {

    if (sel == @selector(runtimeInstanceMethod)) {
        
        // 获取准备替换的方法
        Method method = class_getInstanceMethod(self, @selector(dynamicAddInstanceMethod));
        
        // 动态添加`runtimeTest`方法实现
        class_addMethod(self,
                        sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));
        
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

+ (void)dynamicAddClassMethod {
    
    NSLog(@"%s", __FUNCTION__);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    
    if (sel == @selector(runtimeClassMethod)) {
        
        Method method = class_getClassMethod(self, @selector(dynamicAddClassMethod));
        
        class_addMethod(object_getClass(self),
                        sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));
        return YES;
    }
    return [super resolveClassMethod:sel];
}

@end
