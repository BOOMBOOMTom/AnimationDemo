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

@property (nonatomic, assign) CGFloat x;        //frame.origin.x
@property (nonatomic, assign) CGFloat y;        //frame.origin.y
@property (nonatomic, assign) CGPoint xy;       //frame.origin

@property (nonatomic, assign) CGFloat w;        //frame.size.width
@property (nonatomic, assign) CGFloat h;        //frame.size.height
@property (nonatomic, assign) CGSize  wh;       //frame.size

@property (nonatomic, assign) CGFloat cx;       //center.x
@property (nonatomic, assign) CGFloat cy;       //center.y

@property (nonatomic, assign) CGFloat maxX;     //right of the view
@property (nonatomic, assign) CGFloat maxY;     //bottom of the view
@property (nonatomic, assign) CGPoint maxXY;    //right-bottom point if the view

@property (nonatomic, readonly) CGPoint midPoint;   //bounds center

@end

NS_ASSUME_NONNULL_END
