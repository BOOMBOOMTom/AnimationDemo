//
//  ForegroundColorAttributeConfig.m
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "ForegroundColorAttributeConfig.h"

@implementation ForegroundColorAttributeConfig

-(NSString *)attributeName{
    return NSForegroundColorAttributeName;
}
-(id)attributeValue{
    return self.color ? : UIColor.blackColor;
}

+ (instancetype)configWithColor:(UIColor *)color range:(NSRange)range{
    ForegroundColorAttributeConfig *config = [ForegroundColorAttributeConfig new];
    config.color = color;
    config.attributeRange = range;
    return config;
}
+ (instancetype)configWithColor:(UIColor *)color{
    ForegroundColorAttributeConfig *config = [ForegroundColorAttributeConfig new];
    config.color = color;
    return config;
}

@end
