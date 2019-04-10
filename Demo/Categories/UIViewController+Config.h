//
//  UIViewController+Config.h
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Config)

+ (UIViewController *)getTopViewControllerWithCurrentVC:(UIViewController *)vc;

- (void)setNavigationControllerLeftButton:(UINavigationController *)navi;

- (void)setNavigationControllerLeftButton:(UINavigationController *)navi title:(NSString *)title;

- (void)category_viewVillAppear;
- (void)category_viewWillDisappear;

- (void)goBack;


+ (void)rumtime_swizzing_replace;



@end

NS_ASSUME_NONNULL_END
