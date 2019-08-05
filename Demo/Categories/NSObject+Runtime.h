//
//  NSObject+Runtime.h
//  Demo
//
//  Created by qiao on 04/08/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSObject (Runtime)


- (NSArray *)enumeratePropertyWithBlock:(void(^)(NSInteger idx,NSString *property,BOOL *stop))block;
- (NSArray *)enumerateIvarWithBlock:(void(^)(NSInteger idx,NSString *property,BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
