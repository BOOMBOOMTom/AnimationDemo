//
//  OneVCTableViewItem.h
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneVCTableViewItem : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *vcName;
+ (instancetype)initWithTitle:(NSString *)title vcName:(NSString *)vcName;
@end

NS_ASSUME_NONNULL_END
