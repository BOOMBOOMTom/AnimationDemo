//
//  NSObject+Config.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "NSObject+Config.h"

@implementation NSObject (Config)

+(NSString *)classname{
    return NSStringFromClass([self class]);
}



@end
