//
//  Configs.h
//  Demo
//
//  Created by qiao on 09/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#ifndef Configs_h
#define Configs_h
#import <Foundation/Foundation.h>

@protocol CellSetInfoProtocol <NSObject>
@optional;
- (void)cellSetInfo:(id)info;
- (void)cellSetInfo:(id)info indexPath:(NSIndexPath *)indexPath;
@end

@protocol attributedStringProtocol <NSObject>
@optional
@property (nonatomic, copy) NSString *attributeName;
@property (nonatomic, strong) id attributeValue;
@property (nonatomic, assign) NSRange attributeRange;
@end


#endif /* Configs_h */
