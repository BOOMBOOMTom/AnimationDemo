//
//  NSMutableAttributedString+attributedStringConfig.m
//  Demo
//
//  Created by qiao on 10/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "NSMutableAttributedString+attributedStringConfig.h"


@implementation NSMutableAttributedString (attributedStringConfig)

- (void)addAttributedString:(id<attributedStringProtocol>)obj{
    [self addAttribute:obj.attributeName value:obj.attributeValue range:obj.attributeRange];
}

- (void)removeAttributedString:(id<attributedStringProtocol>)obj{
    [self removeAttribute:obj.attributeName range:obj.attributeRange];
}

+ (NSMutableAttributedString * )attributedStringWithString:(NSString *)string
                                                    config:(void(^)( NSString * string, NSMutableArray <id <attributedStringProtocol>>* array))config{
    
    NSMutableArray *attributeArr = [NSMutableArray array];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string];
    if (config) {
        config(string,attributeArr);
    }
    [attributeArr enumerateObjectsUsingBlock:^(id<attributedStringProtocol> obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attributeString addAttributedString:obj];
    }];
    return attributeString;
}

@end
