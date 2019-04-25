//
//  GCDTimer.h
//  Demo
//
//  Created by qiao on 24/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDTimer : NSObject

- (instancetype)init;

/** 每次循环的间隔 */
- (GCDTimer *(^)(uint64_t timeInterval))timeInterval;
/** 延迟*秒后执行 */
- (GCDTimer *(^)(uint64_t delay))delay;
/** 事件block */
- (GCDTimer *(^)(dispatch_block_t event))eventBlock;
/** 取消block */
- (GCDTimer *(^)(dispatch_block_t cancel))cancelBlock;

- (void)start;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
