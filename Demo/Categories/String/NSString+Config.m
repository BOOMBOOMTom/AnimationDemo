//
//  NSString+Config.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "NSString+Config.h"

@implementation NSString (Config)

- (bool)isEmptyString{
    
    if (![self isKindOfClass:[NSNull class]] && ![self isEqualToString:@"(null)"] && [self length] > 0) {
        return NO;
    }
    return YES;
}

@end
