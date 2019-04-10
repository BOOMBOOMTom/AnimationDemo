//
//  CountDownTableViewCell.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "CountDownTableViewCell.h"

@interface CountDownTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation CountDownTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.titleLabel = [[[[UILabel new]config:^(UILabel * _Nonnull view) {
        view.font = [UIFont systemFontOfSize:16];
        view.text = @"开始倒计时了哦";
    }]addToSuper:self.contentView]layout:^(MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(self.contentView).mas_offset(16);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
}

-(void)cellSetInfo:(id)info indexPath:(NSIndexPath *)indexPath{
    
    NSString *str = [NSString stringWithFormat:@"OneTableViewCell_%td",indexPath.row];
    @weakify(self);
    
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:OYCountDownNotification object:nil] takeUntil:self.rac_prepareForReuseSignal]subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        OYCountDownItem *item = x.object;
        if ([str isEqualToString:item.identifier]) {
            self.titleLabel.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", item.countDown / 3600, (item.countDown / 60) % 60, item.countDown % 60];
        }
    }];
    
}

@end
