//
//  AnimationsViewController.m
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "AnimationsViewController.h"
#import "AppleSystemService.h"
#import "QNotificationDefaultCenter.h"

@interface AnimationsViewController ()

@end

@implementation AnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [AppleSystemService launchImage];
    
    UIImageView *imageView = [[[[UIImageView new]config:^(UIImageView * _Nonnull view) {
        view.image = image;
    }]addToSuper:self.view]layout:^(MASConstraintMaker * _Nonnull make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [UIView animateWithDuration:1 delay:2 options:0 animations:^{
        imageView.scale = 2.f;
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [QNotificationDefaultCenter postNotificationWithName:kLaunchImageShowClose object:nil];
        [imageView removeFromSuperview];
    }];
    
}



@end
