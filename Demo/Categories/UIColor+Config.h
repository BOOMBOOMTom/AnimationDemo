//
//  UIColor+Config.h
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Config)

+ (UIColor *)colorWithHexString:(NSString *)hexString;


+ (UIColor *)colorWithRGB:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIColor *)colorWithRGBA:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (UIColor *)baseColor;

@end

NS_ASSUME_NONNULL_END
