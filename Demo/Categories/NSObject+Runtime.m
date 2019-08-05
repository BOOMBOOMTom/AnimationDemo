//
//  NSObject+Runtime.m
//  Demo
//
//  Created by qiao on 04/08/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

- (NSArray *)enumeratePropertyWithBlock:(void(^)(NSInteger idx,NSString *property,BOOL *stop))block{
    __block BOOL stop = NO;
    NSMutableArray *propertyArray = [NSMutableArray array];
    
    unsigned int count = 0;
    objc_property_t *ivarLists = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char* name = property_getName(ivarLists[i]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [propertyArray addObject:strName];
        if (!stop) {!block?:block(i,strName,&stop);}else{break;}
    }
    free(ivarLists);
    return propertyArray;
}

- (NSArray *)enumerateIvarWithBlock:(void(^)(NSInteger idx,NSString *property,BOOL *stop))block{
    __block BOOL stop = NO;
    NSMutableArray *propertyArray = [NSMutableArray array];
    
    unsigned int count = 0;
    Ivar *ivarLists = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char* name = ivar_getName(ivarLists[i]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [propertyArray addObject:strName];
        if (!stop) {!block?:block(i,strName,&stop);}else{break;}
    }
    free(ivarLists);
    return propertyArray;
}

@end
