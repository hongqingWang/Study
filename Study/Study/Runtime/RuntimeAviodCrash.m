//
//  RuntimeAviodCrash.m
//  Study
//
//  Created by 王红庆 on 2018/7/4.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimeAviodCrash.h"

@implementation RuntimeAviodCrash

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"找不到方法 - %@", NSStringFromSelector(anInvocation.selector));
}

@end
