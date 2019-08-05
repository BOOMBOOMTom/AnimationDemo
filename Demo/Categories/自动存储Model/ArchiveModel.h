//
//  ArchiveModel.h
//  Demo
//
//  Created by qiao on 04/08/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArchiveModel : NSObject

@property (nonatomic, copy) NSString * name;

+ (instancetype)archiveModel;

- (void)saveInfoToLocation;

@end

NS_ASSUME_NONNULL_END
