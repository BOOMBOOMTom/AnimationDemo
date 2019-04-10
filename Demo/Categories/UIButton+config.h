//
//  UIButton+config.h
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QImagePosition) {
    QImagePositionLeft = 0, //图片在左，文字在右，默认
    QImagePositionRight = 1, //图片在右，文字在左
    QImagePositionTop = 2, //图片在上，文字在下
    QImagePositionBottom = 3, //图片在下，文字在上
};


@interface UIButton (config)

- (void)setImagePosition:(QImagePosition)postion spacing:(CGFloat)spacing;

- (void)setImagePosition:(QImagePosition)postion WithMargin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
