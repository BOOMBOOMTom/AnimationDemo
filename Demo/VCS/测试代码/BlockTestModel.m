//
//  BlockTestModel.m
//  Demo
//
//  Created by qiao on 15/06/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "BlockTestModel.h"

@implementation BlockTestModel

- (void)testActionWithBlock:(void(^)(NSString *str))callBack{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !callBack ? : callBack(@"a");
    });
    
}

+ (void)classTestActionWithBlock:(void(^)(NSString *str))callBack{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !callBack ? : callBack(@"a");
    });
}


@end
