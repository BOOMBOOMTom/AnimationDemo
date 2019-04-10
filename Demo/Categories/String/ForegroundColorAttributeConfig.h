//
//  ForegroundColorAttributeConfig.h
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForegroundColorAttributeConfig : NSObject<attributedStringProtocol>

@property (nonatomic, copy) NSString *attributeName;
@property (nonatomic, strong) id attributeValue;
@property (nonatomic, assign) NSRange attributeRange;

@property (nonatomic, strong) UIColor *color;

+ (instancetype)configWithColor:(UIColor *)color range:(NSRange)range;
+ (instancetype)configWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
