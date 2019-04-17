//
//  FieldSearchViewController.m
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "FieldSearchViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface FieldSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pagwSize;
@end

@implementation FieldSearchViewController

-(void)dealloc{
    NSLog(@"----dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNo = 1;
    self.pagwSize = 10;
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.pageNo = 1;
        [self loadDataWithString:@""];
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.pageNo += 1;
        [self loadDataWithString:self.textField.text];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    /**
     这段代码的意思是
     0.3秒内如果没有新的信号输入
     且TF的d内容不为空
     则进行请求
     这对服务器的压力减少有巨大帮助同时提高了用户体验
     就不用专门写timer判断时间差
     只做演示，就不专门找接口请求了
     */
    [[[[[self.textField.rac_textSignal throttle:0.3] distinctUntilChanged] ignore:@""] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        [self loadDataWithString:x];
    }];
    
    
}

- (void)loadDataWithString:(NSString *)string{
    NSLog(@"----laod data begin");
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
