//
//  AssociatePerson+Category.m
//  Study
//
//  Created by 王红庆 on 2018/7/2.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "AssociatePerson+Category.h"
#import <objc/runtime.h>

@implementation AssociatePerson (Category)

- (void)setName:(NSString *)name {
    
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
