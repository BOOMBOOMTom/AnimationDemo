//
//  BlockTestModel.h
//  Demo
//
//  Created by qiao on 15/06/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BlockTestModel : NSObject

- (void)testActionWithBlock:(void(^)(NSString *str))callBack;
+ (void)classTestActionWithBlock:(void(^)(NSString *str))callBack;

@end

NS_ASSUME_NONNULL_END
