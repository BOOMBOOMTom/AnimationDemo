//
//  CountDownViewController.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "CountDownViewController.h"
#import "CountDownTableViewCell.h"


@interface CountDownViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CountDownViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"---%@",[self class]);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        NSLog(@"---%@",[self class]);
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (int i = 0 ; i < 13; i ++) {
        NSString *str = [NSString stringWithFormat:@"OneTableViewCell_%d",i];
        [OYCountDownManager removeCountDownWithIdentifier:str];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CountDown";
    
    self.tableView = [[[[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain]config:^(UITableView * _Nonnull view) {
        view.delegate = self;
        view.dataSource = self;
        TableView_Reg_Cell(view, CountDownTableViewCell);
    }]addToSuper:self.view]layout:^(MASConstraintMaker * _Nonnull make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0 ; i < 13; i ++) {
            NSInteger count = arc4random()%5000;
            NSString *str = [NSString stringWithFormat:@"OneTableViewCell_%d",i];
            [OYCountDownManager addCountDownWithIdentifier:str item:[OYCountDownItem itemWithCountDown:count backgroudRecord:NO]];
        }
        [self.tableView reloadData];
    });
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CountDownTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CountDownTableViewCell.classname forIndexPath:indexPath];
    [cell cellSetInfo:@"" indexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
