//
//  RuntimeDog.m
//  Study
//
//  Created by 王红庆 on 2018/7/4.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimeDog.h"
#import "RuntimeCat.h"
#import <objc/runtime.h>

@implementation RuntimeDog

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(runtimeInstanceMethod)) {
        return [[RuntimeCat alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(runtimeClassMethod)) {
        return [RuntimeCat class];
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
