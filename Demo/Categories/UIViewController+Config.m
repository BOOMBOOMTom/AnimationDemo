//
//  UIViewController+Config.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "UIViewController+Config.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, RunTime_VC_Type) {
    RunTime_VC_Enter = 0,
    RunTime_VC_Leave = 1,
};

@interface UIViewController ()
@property (nonatomic, strong)id popDelegate;
@end

static NSString * const popDelegateKey = @"popDelegateKey";

@implementation UIViewController (Config)

- (void)setPopDelegate:(id)popDelegate{
    objc_setAssociatedObject(self, &popDelegateKey, popDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(id)popDelegate{
    return objc_getAssociatedObject(self, &popDelegateKey);
}

- (void)category_viewVillAppear{
    self.popDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
- (void)category_viewWillDisappear{
    self.navigationController.interactivePopGestureRecognizer.delegate = self.popDelegate;
}

+ (UIViewController *)getTopViewControllerWithCurrentVC:(UIViewController *)vc{
    
    UIViewController *viewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        viewController = [self getTopViewControllerWithCurrentVC:[(UINavigationController *)vc visibleViewController]];
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        viewController = [self getTopViewControllerWithCurrentVC:[(UITabBarController *)vc selectedViewController]];
    }else if ([vc presentedViewController]){
        viewController = [self getTopViewControllerWithCurrentVC:[vc presentedViewController]];
    }else{
        viewController = vc;
    }
    return viewController;
}

- (void)setNavigationControllerLeftButton:(UINavigationController *)navi{
    [self setNavigationControllerLeftButton:navi title:@""];
}

- (void)setNavigationControllerLeftButton:(UINavigationController *)navi title:(NSString *)title{
    
    UIButton *button = [[UIButton buttonWithType:UIButtonTypeCustom]config:^(UIButton * _Nonnull view) {
        view.frame = CGRectMake(0, 0, 30, 30);
        if (![title isEmptyString]) {
            [view setTitle:title forState:UIControlStateNormal];
            [view setTitle:title forState:UIControlStateSelected];
        }
        [view setImage:Image(@"back_black") forState:UIControlStateNormal];
        [view setImage:Image(@"back_black") forState:UIControlStateSelected];
        [view setImagePosition:QImagePositionLeft spacing:5];
        [view addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

+ (void)rumtime_swizzing_replace{
    
    {
        Method originaMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
        Method newMerhod = class_getInstanceMethod([self class], @selector(runtime_replace_viewDidAppear:));
        method_exchangeImplementations(originaMethod, newMerhod);
    }
    {
        Method originaMethod = class_getInstanceMethod([self class], @selector(viewDidDisappear:));
        Method newMerhod = class_getInstanceMethod([self class], @selector(runtime_replace_viewDidDisappear:));
        method_exchangeImplementations(originaMethod, newMerhod);
    }
    
}

- (void)runtime_replace_viewDidAppear:(BOOL)animated{
    [self runtime_replace_viewDidAppear:animated];
    [self debugEnvVcType:RunTime_VC_Enter];
}

- (void)runtime_replace_viewDidDisappear:(BOOL)animated{
    [self runtime_replace_viewDidDisappear:animated];
    [self debugEnvVcType:RunTime_VC_Leave];
}

- (void)debugEnvVcType:(RunTime_VC_Type)type{
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm:ss.SSS";
    NSString *time = [formatter stringFromDate:[NSDate date]];
    
    NSString *outputStr;
    switch (type) {
        case RunTime_VC_Enter:
            outputStr = [NSString stringWithFormat:@"[➡️] Did-Enter-Class--%@--%@",[self class],time];
            break;
        case RunTime_VC_Leave:
            outputStr = [NSString stringWithFormat:@"[⛔️] Did-Leave-Class--%@--%@",[self class],time];
            break;            
        default:
            break;
    }
    NSLog(@"%@",outputStr);
    
}

@end
