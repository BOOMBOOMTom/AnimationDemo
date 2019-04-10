//
//  UIView+Config.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "UIView+Config.h"
#import <objc/runtime.h>

static NSString * const kScaleKey = @"kScaleKey";

@implementation UIView (Config)

- (instancetype)config:(void(^)(__kindof UIView * view))block{
    !block?:block(self);
    return self;
}
- (instancetype)addToSuper:(UIView *)view{
    [view addSubview:self];
    return self;
}
#if __has_include(<UIKit/UIKit.h>)
- (instancetype)layout:(void(^)(MASConstraintMaker *make))layout{
    NSParameterAssert(self.superview);
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        !layout?:layout(make);
    }];
    return self;
}
#endif


-(void)setScale:(CGFloat)scale{
    objc_setAssociatedObject(self, &kScaleKey, @(scale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeScale(scale, scale);
}
-(CGFloat)scale{
    NSNumber *scale = objc_getAssociatedObject(self, &kScaleKey);
    return scale.floatValue;
}






@end
