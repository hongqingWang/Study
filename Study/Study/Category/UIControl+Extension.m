//
//  UIControl+Extension.m
//  Study
//
//  Created by 王红庆 on 2018/7/5.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>

@implementation UIControl (Extension)

+ (void)load {
    
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method method2 = class_getInstanceMethod(self, @selector(qq_sendAction:to:forEvent:));
    method_exchangeImplementations(method1, method2);
}

- (void)qq_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    [self qq_sendAction:action to:target forEvent:event];
//    NSLog(@"%@", self);
//    NSLog(@"%@", target);
//    NSLog(@"%@", NSStringFromSelector(action));
}

@end
