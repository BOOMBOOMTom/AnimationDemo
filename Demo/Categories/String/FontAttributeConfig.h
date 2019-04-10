//
//  FontAttributeConfig.h
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontAttributeConfig : NSObject<attributedStringProtocol>

@property (nonatomic, copy) NSString *attributeName;
@property (nonatomic, strong) id attributeValue;
@property (nonatomic, assign) NSRange attributeRange;

@property (nonatomic, strong) UIFont *font;

+ (instancetype)configWithFont:(UIFont *)font range:(NSRange)range;
+ (instancetype)configWithFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
