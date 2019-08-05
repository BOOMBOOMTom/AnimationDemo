//
//  EmitterAnimationViewController.m
//  Demo
//
//  Created by qiao on 17/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "EmitterAnimationViewController.h"

#define EmitterColor_Red      [UIColor colorWithRed:255/255.0 green:0 blue:139/255.0 alpha:1]
#define EmitterColor_Yellow   [UIColor colorWithRed:251/255.0 green:197/255.0 blue:13/255.0 alpha:1]
#define EmitterColor_Blue     [UIColor colorWithRed:50/255.0 green:170/255.0 blue:207/255.0 alpha:1]

@interface EmitterAnimationViewController ()
@property (nonatomic, strong) UIButton *startBtn;
@end

@implementation EmitterAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"点一下就知道了";
    
    self.startBtn = [[[[UIButton buttonWithType:UIButtonTypeCustom]config:^(UIButton * _Nonnull view) {
        [view setTitle:@"Start" forState:UIControlStateNormal];
        view.backgroundColor = UIColor.orangeColor;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
    }]addToSuper:self.view]layout:^(MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.bottom.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_offset(50);
    }];
    
    @weakify(self);
    [[[self.startBtn rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        UIView *view = [[[UIView new]config:^(__kindof UIView * _Nonnull view) {
            view.backgroundColor = UIColor.clearColor;
        }]addToSuper:self.view];
        view.w = SCREEN_WIDTH - 60;
        view.xy = CGPointMake(SCREEN_WIDTH, 200);
        [UIView animateWithDuration:0.15 animations:^{
            view.x = (SCREEN_WIDTH - view.w) / 2.f;
        } completion:^(BOOL finished) {
            //开始粒子效果
            CAEmitterLayer *emitterLayer = addEmitterLayer(self.view, view);
            startAnimate(emitterLayer);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:0.15 animations:^{
                    view.x = -SCREEN_WIDTH;
                } completion:^(BOOL finished) {
                    [view removeFromSuperview];
                }];
            });
        }];
    }];
    
}



CAEmitterLayer *addEmitterLayer(UIView *view, UIView *window)
{
    
    //色块粒子
    CAEmitterCell *subCell1 = subCell(imageWithColor(EmitterColor_Red));
    subCell1.name = @"red";
    CAEmitterCell *subCell2 = subCell(imageWithColor(EmitterColor_Yellow));
    subCell2.name = @"yellow";
    CAEmitterCell *subCell3 = subCell(imageWithColor(EmitterColor_Blue));
    subCell3.name = @"blue";
    CAEmitterCell *subCell4 = subCell([UIImage imageNamed:@"success_star"]);
    subCell4.name = @"star";
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = window.center;
    emitterLayer.emitterPosition = window.center;
    emitterLayer.emitterSize    = window.bounds.size;
    emitterLayer.emitterMode    = kCAEmitterLayerOutline;
    emitterLayer.emitterShape    = kCAEmitterLayerRectangle;
    emitterLayer.renderMode        = kCAEmitterLayerOldestFirst;
    
    emitterLayer.emitterCells = @[subCell1,subCell2,subCell3,subCell4];
    [view.layer addSublayer:emitterLayer];
    
    return emitterLayer;
    
}

void startAnimate(CAEmitterLayer *emitterLayer)
{
    CABasicAnimation *redBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.red.birthRate"];
    redBurst.fromValue        = [NSNumber numberWithFloat:30];
    redBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    redBurst.duration        = 0.5;
    redBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *yellowBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.yellow.birthRate"];
    yellowBurst.fromValue        = [NSNumber numberWithFloat:30];
    yellowBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    yellowBurst.duration        = 0.5;
    yellowBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *blueBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.blue.birthRate"];
    blueBurst.fromValue        = [NSNumber numberWithFloat:30];
    blueBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    blueBurst.duration        = 0.5;
    blueBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *starBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.star.birthRate"];
    starBurst.fromValue        = [NSNumber numberWithFloat:30];
    starBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    starBurst.duration        = 0.5;
    starBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[redBurst,yellowBurst,blueBurst,starBurst];
    
    [emitterLayer addAnimation:group forKey:@"heartsBurst"];
}

CAEmitterCell *subCell(UIImage *image)
{
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    
    cell.name = @"heart";
    cell.contents = (__bridge id _Nullable)image.CGImage;
    
    // 缩放比例
    cell.scale      = 0.6;
    cell.scaleRange = 0.6;
    // 每秒产生的数量
    //    cell.birthRate  = 40;
    cell.lifetime   = 20;
    // 每秒变透明的速度
    //    snowCell.alphaSpeed = -0.7;
    //    snowCell.redSpeed = 0.1;
    // 秒速
    cell.velocity      = 200;
    cell.velocityRange = 200;
    cell.yAcceleration = 9.8;
    cell.xAcceleration = 0;
    //掉落的角度范围
    cell.emissionRange  = M_PI;
    
    cell.scaleSpeed        = -0.05;
    ////    cell.alphaSpeed        = -0.3;
    cell.spin            = 2 * M_PI;
    cell.spinRange        = 2 * M_PI;
    
    return cell;
}

UIImage *imageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0, 0, 13, 17);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
