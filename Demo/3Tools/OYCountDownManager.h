//
//  CountDownManager.h
//  CellCountDown
//
//  Created by herobin on 16/9/11.
//  Copyright © 2016年 herobin. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 倒计时的通知名 */
extern NSString *const OYCountDownNotification;

@class OYCountDownItem;
/**用于接收通知类实现的函数*/
@protocol OYCountDownItemProtocol <NSObject>

@required
/**相应类 倒计时标记*/
@property (nonatomic, copy) NSString *countDownItemIdentifier;
/**相应类 时间到了的回调*/
@property (nonatomic, copy) void(^countDownItemTiemUpComlepte)(OYCountDownItem *countDownItem);

@end

@interface OYCountDownItem: NSObject

@property (nonatomic,   copy, readonly) NSString *identifier;
@property (nonatomic, assign, readonly) NSInteger countDown;
@property (nonatomic, assign, readonly) BOOL timeUp;
@property (nonatomic, assign, readonly) BOOL isBecomeActive;  //标记本次是否是从后台进入前台
/// 后台模式使用, 记录进入后台的本地时间
@property (nonatomic, assign, readonly) BOOL backgroudRecord;

+ (instancetype)itemWithCountDown:(NSUInteger)countDown backgroudRecord:(BOOL)backgroudRecord;

@end

@interface OYCountDownManager : NSObject

/**添加倒计时*/
+ (void)addCountDownWithIdentifier:(NSString *)identifier item:(OYCountDownItem *)item;

/**删除倒计时 倒计时到了之后, 也会自动移除*/
+ (void)removeCountDownWithIdentifier:(NSString *)identifier;

/**根据标记获取对应的item*/
+ (OYCountDownItem *)itemForIdentifier:(NSString *)identifier;

/**当前所有的identifier*/
+ (NSArray <NSString *>*)allIdetifiers;

@end


