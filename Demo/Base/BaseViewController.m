//
//  ViewController.m
//  Demo
//
//  Created by qiao on 2019/4/1.
//  Copyright © 2019年 tg. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self category_viewVillAppear];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self category_viewWillDisappear];
}
- (void)dealloc {
#ifdef DEBUG
    NSLog(@"[⚠️] dealloc -- %@",[self class]);
#endif
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationControllerLeftButton:self.navigationController];
    
}


@end
