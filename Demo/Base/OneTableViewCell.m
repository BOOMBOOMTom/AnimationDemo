//
//  OneTableViewCell.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "OneTableViewCell.h"
#import "OneVCTableViewItem.h"
#import <pop/POP.h>

@interface OneTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *vcNameLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) OneVCTableViewItem *info;
@end

@implementation OneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.button = [[[[UIButton buttonWithType:UIButtonTypeCustom]config:^(UIButton * _Nonnull view) {
        view.backgroundColor = UIColor.clearColor;
    }]addToSuper:self.contentView]layout:^(MASConstraintMaker * _Nonnull make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    self.titleLabel = [[[[UILabel new]config:^(UILabel * _Nonnull view) {
        view.font = [UIFont systemFontOfSize:16];
    }]addToSuper:self.contentView]layout:^(MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(self.contentView).mas_offset(16);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    self.vcNameLabel = [[[[UILabel new]config:^(UILabel * _Nonnull view) {
        view.font = [UIFont systemFontOfSize:12];
        view.textAlignment = NSTextAlignmentRight;
        view.textColor = UIColor.grayColor;
    }]addToSuper:self.contentView]layout:^(MASConstraintMaker * _Nonnull make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-16);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(13);
    }];
}

-(void)cellSetInfo:(OneVCTableViewItem *)info indexPath:(NSIndexPath *)indexPath{
    
    self.contentView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor : [UIColor.grayColor colorWithAlphaComponent:0.15f];
    
    self.info = info;
    
    self.vcNameLabel.text = info.vcName;
    
    NSString *text = [NSString stringWithFormat:@"%02td. %@",indexPath.row + 1,info.title];
    
    self.titleLabel.attributedText = [NSMutableAttributedString attributedStringWithString:text config:^(NSString * _Nonnull string, NSMutableArray<id<attributedStringProtocol>> * _Nonnull array) {
        [array addObject:[FontAttributeConfig configWithFont:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string.length)]];
        [array addObject:[FontAttributeConfig configWithFont:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 3)]];
        [array addObject:[ForegroundColorAttributeConfig configWithColor:UIColor.blackColor range:NSMakeRange(0, string.length)]];
        [array addObject:[ForegroundColorAttributeConfig configWithColor:UIColor.redColor range:NSMakeRange(0, 3)]];
    }];
    
    @weakify(self);
    [[[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        UIViewController *topVC = [UIViewController getTopViewControllerWithCurrentVC:RootVC];
        [topVC.navigationController pushViewController:[[NSClassFromString(self.info.vcName) class] new] animated:YES];
    }];
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {
        
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.1f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
    } else {
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness    = 20.f;
        [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
    
}
@end
