//
//  QNotificationDefaultCenter.h
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNotificationDefaultCenter : NSObject

+ (void)postNotificationWithName:(NSString *)name object:(_Nullable id)obj;

@end

NS_ASSUME_NONNULL_END
