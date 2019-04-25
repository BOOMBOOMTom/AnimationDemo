//
//  FadeAnimationViewController.m
//  Demo
//
//  Created by qiao on 24/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "FadeAnimationViewController.h"
#import "GCDTimer.h"

@interface FadeAnimationViewController ()
@property (nonatomic, strong) GCDTimer *timer;
@end

@implementation FadeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.timer = [[GCDTimer alloc]init];
    
    @weakify(self);
    __block int a = 0;
    [self.timer.timeInterval(1).delay(3).eventBlock(^{
        @strongify(self);
        a+=1;
        NSLog(@"------%d",a);
        if (a == 10) {
            [self.timer cancel];
        }
    }).cancelBlock(^{
        NSLog(@"cancel");
    }) start];
    
}



@end
