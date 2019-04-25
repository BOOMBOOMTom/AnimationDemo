//
//  GCDTimer.m
//  Demo
//
//  Created by qiao on 24/04/2019.
//  Copyright © 2019 tg. All rights reserved.
//

#import "GCDTimer.h"

@interface GCDTimer ()

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, assign) uint64_t block_interval;
@property (nonatomic, assign) uint64_t block_delay;
@property (nonatomic, copy) dispatch_block_t block_event;
@property (nonatomic, copy) dispatch_block_t block_cencel;

@end

@implementation GCDTimer

-(instancetype)init{
    if (self = [super init]) {
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        self.block_interval = 1;
        self.block_delay = 0;
    }
    return self;
}

- (GCDTimer *(^)(uint64_t timeInterval))timeInterval
{
    return ^(uint64_t timeInterval){
        self.block_interval = timeInterval;
        return self;
    };
}
- (GCDTimer *(^)(uint64_t delay))delay
{
    return ^(uint64_t delay){
        self.block_delay = delay;
        return self;
    };
}
- (GCDTimer *(^)(dispatch_block_t event))eventBlock
{
    return ^(dispatch_block_t event){
        self.block_event = event;
        return self;
    };
}
- (GCDTimer *(^)(dispatch_block_t cancel))cancelBlock
{
    return ^(dispatch_block_t cancel){
        self.block_cencel = cancel;
        return self;
    };
}

-(void)start{
    
    if (self.block_event) {
        dispatch_source_set_event_handler(self.timer, self.block_event);
    }
    if (self.block_cencel) {
        dispatch_source_set_cancel_handler(self.timer, self.block_cencel);
    }
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, self.block_delay * NSEC_PER_SEC), self.block_interval * NSEC_PER_SEC, 0);
    
    dispatch_resume(self.timer);
    
}

-(void)cancel{
    dispatch_source_cancel(self.timer);
}



@end
