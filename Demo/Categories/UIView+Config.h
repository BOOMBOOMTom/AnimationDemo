//
//  UIView+Config.h
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <UIKit/UIKit.h>


#if __has_include(<UIKit/UIKit.h>)
#import <Masonry/Masonry.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Config)

- (instancetype)config:(void(^)(__kindof UIView * view))block;
- (instancetype)addToSuper:(UIView *)view;
#if __has_include(<UIKit/UIKit.h>)
- (instancetype)layout:(void(^)(MASConstraintMaker *make))layout;
#endif


@property (nonatomic, assign) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
