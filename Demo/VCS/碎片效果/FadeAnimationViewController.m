//
//  FadeAnimationViewController.m
//  Demo
//
//  Created by qiao on 24/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "FadeAnimationViewController.h"
#import "GCDTimer.h"
#import <Aspects/Aspects.h>

@interface FadeAnimationViewController ()
@property (nonatomic, strong) GCDTimer *timer;
@end

@implementation FadeAnimationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
//    self.timer = [[GCDTimer alloc]init];
//
//    @weakify(self);
//    __block int a = 0;
//    [self.timer.timeInterval(1).delay(3).eventBlock(^{
//        @strongify(self);
//        a+=1;
//        NSLog(@"------%d",a);
//        if (a == 10) {
//            [self.timer cancel];
//        }
//    }).cancelBlock(^{
//        NSLog(@"cancel");
//    }) start];
    
    // GCD demo
    dispatch_group_t group = dispatch_group_create();
    NSUInteger count = [NSProcessInfo processInfo].processorCount;
    dispatch_queue_t queue = dispatch_queue_create("com.demo1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t gloab = dispatch_queue_create("com.demo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t sema = dispatch_semaphore_create(count * 2);
    
    for (int i = 0; i < 10;  i ++) {
        
        // 1 semaphore + serial
        // 2 group (enter + leave)
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"----- i ---- %d",i);
            dispatch_group_async(group, gloab, ^{
                
                
                sleep(1);
                
                dispatch_semaphore_signal(sema);
                NSLog(@"----- i ---- %d -- 22222 ",i);
        
//                dispatch_group_async(group, queue, ^{
//                    dispatch_semaphore_signal(sema);
//                    NSLog(@"----- i ---- %d -- 22222 ",i);
//                });
                
            });
            
        });
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"3333333333");
    
    
    
    
}



@end
