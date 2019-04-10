//
//  QNotificationDefaultCenter.m
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "QNotificationDefaultCenter.h"

@implementation QNotificationDefaultCenter

+ (void)postNotificationWithName:(NSString *)name object:(_Nullable id)obj{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
}

@end
