//
//  ArchiveModel.m
//  Demo
//
//  Created by qiao on 04/08/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "ArchiveModel.h"
#import "NSObject+Runtime.h"

#define kLocalPath         [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", [NSString stringWithFormat:@"%@-Qiao-%@", @"ArchiverObject", NSStringFromClass([self class])]]

@interface ArchiveModel ()<NSCoding>{
    BOOL _hasAddObserver;
}

@end

@implementation ArchiveModel

static ArchiveModel *archiveModel = nil;

+(instancetype)alloc{
    NSAssert(!archiveModel, @"ArchiveModel为单例,已经在内存中存在");
    return [super alloc];
}

+ (instancetype)archiveModel{
    if (!archiveModel) {
        NSError *error;
        NSLog(@"%@",kLocalPath);
        if (@available(iOS 10.0, *)) {
            archiveModel = (ArchiveModel *)[NSKeyedUnarchiver unarchivedObjectOfClass:[self class] fromData:[NSData dataWithContentsOfFile:kLocalPath] error:&error];
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            archiveModel = [NSKeyedUnarchiver unarchiveObjectWithFile:kLocalPath];
#pragma clang diagnostic pop
        }
        if (error || !archiveModel) {
            archiveModel = [ArchiveModel new];
        }
        [archiveModel addObserverWithModel];
    }
    return archiveModel;
}

-(void)dealloc{
    [self enumeratePropertyWithBlock:^(NSInteger idx, NSString * _Nonnull property, BOOL * _Nonnull stop) {
        [self removeObserver:self forKeyPath:property];
    }];
}

-(void)saveInfoToLocation{
    NSError *error;
    if (@available(iOS 10.0, *)) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:NO error:&error];
        if (error) {return;}
        [data writeToFile:kLocalPath atomically:YES];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [NSKeyedArchiver archiveRootObject:self toFile:kLocalPath];
#pragma clang diagnostic pop
    }
    
}

- (void)addObserverWithModel{
    if (!_hasAddObserver) {
        [self enumeratePropertyWithBlock:^(NSInteger idx, NSString * _Nonnull property, BOOL * _Nonnull stop) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
        }];
    }
    _hasAddObserver = YES;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self saveInfoToLocation];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self enumeratePropertyWithBlock:^(NSInteger idx, NSString * _Nonnull property, BOOL * _Nonnull stop) {
        [aCoder encodeObject:[self valueForKey:property] forKey:property];
    }];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [self enumeratePropertyWithBlock:^(NSInteger idx, NSString * _Nonnull property, BOOL * _Nonnull stop) {
            @try {
                [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
            } @catch (NSException *exception) {
                NSLog(@"无法归档字段：class:%@ --- property:%@",[self class],property);
            }
        }];
    }
    return self;
}

@end
