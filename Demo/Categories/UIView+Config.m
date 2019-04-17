//
//  UIView+Config.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "UIView+Config.h"
#import <objc/runtime.h>

#define NER_UPDATE_FRAME(target, value) CGRect rect = self.frame; rect.target = value; self.frame = rect;
#define NER_UPDATE_CENTER(target, value) CGPoint center = self.center; center.target = value; self.center = center;

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

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    NER_UPDATE_FRAME(origin.x, x);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    NER_UPDATE_FRAME(origin.y, y);
}

- (CGPoint)xy {
    return self.frame.origin;
}

- (void)setXy:(CGPoint)xy {
    NER_UPDATE_FRAME(origin, xy);
}

- (CGFloat)w {
    return self.frame.size.width;
}

- (void)setW:(CGFloat)width {
    NER_UPDATE_FRAME(size.width, width);
}

- (CGFloat)h {
    return self.frame.size.height;
}

- (void)setH:(CGFloat)height {
    NER_UPDATE_FRAME(size.height, height);
}

- (CGSize)wh {
    return self.frame.size;
}

- (void)setWh:(CGSize)size {
    NER_UPDATE_FRAME(size, size);
}

- (CGFloat)cx {
    return self.center.x;
}

- (void)setCx:(CGFloat)cx {
    NER_UPDATE_CENTER(x, cx);
}

- (CGFloat)cy {
    return self.center.y;
}

- (void)setCy:(CGFloat)cy {
    NER_UPDATE_CENTER(y, cy);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX {
    NER_UPDATE_FRAME(origin.x, maxX - rect.size.width);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    NER_UPDATE_FRAME(origin.y, maxY - rect.size.height);
}

- (CGPoint)maxXY {
    return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
}

- (void)setMaxXY:(CGPoint)maxXY {
    NER_UPDATE_FRAME(origin, CGPointMake(maxXY.x - rect.size.width, maxXY.y - rect.size.height));
}

- (CGPoint)midPoint {
    return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}




@end
