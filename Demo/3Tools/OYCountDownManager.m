//
//  CountDownManager.m
//  CellCountDown
//
//  Created by herobin on 16/9/11.
//  Copyright © 2016年 herobin. All rights reserved.
//

#import "OYCountDownManager.h"

NSString *const OYCountDownNotification = @"OYCountDownNotification";


@interface OYCountDownItem ()

@property (nonatomic,   copy) NSString *identifier;
@property (nonatomic, assign) NSInteger countDown;
@property (nonatomic, assign) BOOL isBecomeActive;  //标记本次是否是从后台进入前台
@property (nonatomic, assign) BOOL backgroudRecord;
    
@end

@implementation OYCountDownItem

- (BOOL)timeUp
{
    return _countDown <= 0;
}

+ (instancetype)itemWithCountDown:(NSUInteger)countDown backgroudRecord:(BOOL)backgroudRecord;
{
    OYCountDownItem *item = [[OYCountDownItem alloc] init];
    item.countDown = countDown;
    item.backgroudRecord = backgroudRecord;
    return item;
}
@end


@interface OYCountDownManager ()

@property (nonatomic, strong) NSTimer *timer;

/// 后台模式使用, 记录进入后台的本地时间
@property (nonatomic, assign) BOOL backgroudRecord;

@property (nonatomic, strong) NSMutableDictionary <NSString *, OYCountDownItem *> *dictionaryWithAllCountDown;

@property (nonatomic, strong) NSDate *resignBackgroundDate;

@end

@implementation OYCountDownManager

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)addCountDownWithIdentifier:(NSString *)identifier item:(OYCountDownItem *)item
{
    item.identifier = identifier;
    [[[self manager] dictionaryWithAllCountDown] setObject:item forKey:identifier];
    
    [[self manager] timer];
    
    //主动发起一次, 用于业务方第一次赋值
    [[NSNotificationCenter defaultCenter] postNotificationName:OYCountDownNotification object:item userInfo:nil];
}

+ (void)removeCountDownWithIdentifier:(NSString *)identifier
{
    NSMutableDictionary *dict = [[self manager] dictionaryWithAllCountDown];
    [dict removeObjectForKey:identifier];
    if (dict.count == 0) {
        [[self manager] invalidate];
    }
}

+ (OYCountDownItem *)itemForIdentifier:(NSString *)identifier
{
    return [[self manager] dictionaryWithAllCountDown][identifier];
}

+ (NSArray <NSString *>*)allIdetifiers;
{
    return [[self manager] dictionaryWithAllCountDown].allKeys;
}

#pragma mark - PrivateMethods

+ (instancetype)manager
{
    static OYCountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OYCountDownManager alloc] init];
        manager.dictionaryWithAllCountDown = [NSMutableDictionary dictionary];;
        
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(resetCountDown) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(resignActiveToRecordState) name:UIApplicationWillResignActiveNotification object:nil];
    });
    return manager;
}

- (void)invalidate
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)actionCountDown
{
    if (self.dictionaryWithAllCountDown.count == 0) {
        [[[self class] manager] invalidate];
    }

    @weakify(self)
    [self.dictionaryWithAllCountDown enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, OYCountDownItem * _Nonnull obj, BOOL * _Nonnull stop) {
        @strongify(self)
        obj.countDown--;
        if (obj.countDown < 0) { obj.countDown = 0; }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:OYCountDownNotification object:obj userInfo:nil];
        if (obj.timeUp) {
            [self.dictionaryWithAllCountDown removeObjectForKey:key];
        }
    }];
}

- (void)resetCountDown;
{
    [self.dictionaryWithAllCountDown enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, OYCountDownItem * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.isBecomeActive = YES;
        
        NSTimeInterval timeHasGone = [[NSDate date] timeIntervalSinceDate:self.resignBackgroundDate];
        if (obj.backgroudRecord && obj.countDown - timeHasGone > 0) {
            obj.countDown = obj.countDown - timeHasGone;
        }else {
            obj.countDown = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:OYCountDownNotification object:obj userInfo:nil];
        }
        obj.isBecomeActive = NO;
    }];
}

- (void)resignActiveToRecordState
{
    self.resignBackgroundDate = [NSDate date];
}

#pragma mark - GetMethods

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionCountDown) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
