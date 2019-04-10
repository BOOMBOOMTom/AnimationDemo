//
//  OneVCTableViewItem.m
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "OneVCTableViewItem.h"

@interface OneVCTableViewItem ()
@property (nonatomic, copy) NSString *vcName;
@property (nonatomic, copy) NSString *title;
@end

@implementation OneVCTableViewItem

+ (instancetype)initWithTitle:(NSString *)title vcName:(NSString *)vcName{
    
    OneVCTableViewItem *item = [OneVCTableViewItem new];
    item.vcName = vcName;
    item.title = title;
    return item;
}

@end
