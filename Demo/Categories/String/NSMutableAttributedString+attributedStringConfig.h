//
//  NSMutableAttributedString+attributedStringConfig.h
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FontAttributeConfig.h"
#import "ForegroundColorAttributeConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (attributedStringConfig)

- (void)addAttributedString:(id<attributedStringProtocol>)obj;

- (void)removeAttributedString:(id<attributedStringProtocol>)obj;

+ (NSMutableAttributedString * )attributedStringWithString:(NSString *)string
                                                    config:(void(^)( NSString * string, NSMutableArray <id <attributedStringProtocol>>* array))config;

@end

NS_ASSUME_NONNULL_END
