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
#import <pthread.h>
#import "BlockTestModel.h"
#import "ArchiveModel.h"

static void Q_Dispatch_Async_MianQueue(dispatch_block_t block) {
    if (pthread_main_np() == 1) {
        !block ?: block();
    }else{
        !block ?:dispatch_async(dispatch_get_main_queue(), block);
    }
}

static void Q_Dispatch_Sync_MianQueue(dispatch_block_t block) {
    if (pthread_main_np() == 1) {
        !block ?: block();
    }else{
        !block ?:dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@interface FadeAnimationViewController ()
@property (nonatomic, strong) GCDTimer *timer;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, copy) NSString *str;
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
    
    // ----------------------------------------------------------------------------------------
    
    // GCD demo 1
//    dispatch_group_t group = dispatch_group_create();
//    NSUInteger count = [NSProcessInfo processInfo].processorCount;
//    dispatch_queue_t queue = dispatch_queue_create("com.demo1", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t gloab = dispatch_queue_create("com.demo", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_semaphore_t sema = dispatch_semaphore_create(count * 2);
//
//    for (int i = 0; i < 10;  i ++) {
//
//        // 1 semaphore + serial
//        // 2 group (enter + leave)
//
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        dispatch_group_async(group, queue, ^{
//            NSLog(@"----- i ---- %d",i);
//            dispatch_group_async(group, gloab, ^{
//
//
//                sleep(1);
//
//                dispatch_semaphore_signal(sema);
//                NSLog(@"----- i ---- %d -- 22222 ",i);
//
////                dispatch_group_async(group, queue, ^{
////                    dispatch_semaphore_signal(sema);
////                    NSLog(@"----- i ---- %d -- 22222 ",i);
////                });
//
//            });
//
//        });
//    }
//
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    NSLog(@"3333333333");
    
    // ----------------------------------------------------------------------------------------
    
    // GCD demo 2
//
    // dispatch_group_wait 为同步 会阻塞主线程

//    dispatch_queue_t queue = dispatch_queue_create("111.com", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//
//        dispatch_group_t group = dispatch_group_create();
//
//        //dispatch_group_enter(group);
//        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//
//            //dispatch_group_leave(group);
//
//            // dispatch_group_async里放异步代码，会直接跳过，然后执行dispatch_group_notify(不等待执行完)
//
////            dispatch_async(dispatch_queue_create("22222", DISPATCH_QUEUE_SERIAL), ^{
////                sleep(2);
////
////                NSLog(@"222222222");
////            });
//
//            // dispatch_group_async里放同步代码，会等待执行完，然后执行dispatch_group_notify
//
//            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//                sleep(2);
//                NSLog(@"222222222");
//            });
//
//        });
//
//        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//        NSLog(@"333333333");
//    });
//    NSLog(@"111111111");
    
   
    // ----------------------------------------------------------------------------------------
    
    
//    BlockTestModel *model = [BlockTestModel new];
//    [model testActionWithBlock:^(NSString * _Nonnull str) {
//        self.str = str;
//        NSLog(@"---------%@",self.str);
//    }];
    
//    [BlockTestModel classTestActionWithBlock:^(NSString * _Nonnull str) {
//        self.str = str;
//        NSLog(@"---------%@",self.str);
//    }];
    
    ArchiveModel *model = [ArchiveModel archiveModel];
    model.name = @"张三";
    
}



@end
