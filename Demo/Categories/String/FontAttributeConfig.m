//
//  FontAttributeConfig.m
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "FontAttributeConfig.h"

@implementation FontAttributeConfig

-(NSString *)attributeName{
    return NSFontAttributeName;
}
-(id)attributeValue{
    return self.font ? : [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

+ (instancetype)configWithFont:(UIFont *)font range:(NSRange)range{
    FontAttributeConfig *config = [FontAttributeConfig new];
    config.font = font;
    config.attributeRange = range;
    return config;
}
+ (instancetype)configWithFont:(UIFont *)font{
    FontAttributeConfig *config = [FontAttributeConfig new];
    config.font = font;
    return config;
}

@end
