//
//  OneViewController.m
//  Demo
//
//  Created by qiao on 2019/4/1.
//  Copyright © 2019年 tg. All rights reserved.
//

#import "OneViewController.h"
#import "OneVCTableViewItem.h"
#import "CountDownViewController.h"
#import "OneTableViewCell.h"
#import "FieldSearchViewController.h"
#import "EmitterAnimationViewController.h"
#import "FadeAnimationViewController.h"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, assign) BOOL readyReloadData;

@end



@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demo";
    
    self.sourceArray = @[
                         [OneVCTableViewItem initWithTitle:@"一个简单的倒计时" vcName:CountDownViewController.classname],
                         [OneVCTableViewItem initWithTitle:@"即时搜索" vcName:FieldSearchViewController.classname],
                         [OneVCTableViewItem initWithTitle:@"进场粒子效果" vcName:EmitterAnimationViewController.classname],
                         [OneVCTableViewItem initWithTitle:@"测试代码" vcName:FadeAnimationViewController.classname],
                         ];
    
    self.tableView.tableFooterView = [UIView new];
    TableView_Reg_Cell(self.tableView, OneTableViewCell)
    self.tableView.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kLaunchImageShowClose object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.tableView.hidden = NO;
        NSMutableArray *indexArr = [NSMutableArray arrayWithCapacity:self.sourceArray.count];
        for (int i = 0; i < self.sourceArray.count; i ++) {
            [indexArr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        self.readyReloadData = YES;
        [self.tableView insertRowsAtIndexPaths:indexArr withRowAnimation:UITableViewRowAnimationFade];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.readyReloadData ? self.sourceArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneTableViewCell.classname forIndexPath:indexPath];
    [cell cellSetInfo:self.sourceArray[indexPath.row] indexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
