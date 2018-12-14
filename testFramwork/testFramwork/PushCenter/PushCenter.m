//
//  PushCenter.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/20.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "PushCenter.h"
#import "SingletionClass.h"

@interface PushCenter()

@property (nonatomic, strong) NSPointerArray *listners;

@end

@implementation PushCenter

- (void)registerListner:(id<PushCenterDelegate>)listner {
    [self.listners addPointer:(__bridge void * _Nullable)(listner)];
}

- (void)pushMessage:(PCMessage *)message {
    for (id<PushCenterDelegate> listner in self.listners.allObjects) {
        if (listner.expectMessage & message.type) {
            [listner pushCenter:self didReceiveMessage:message];
        }
    }
}

+ (instancetype)share {
    Singleton();
}

#pragma mark - getter setter
- (NSPointerArray *)listners {
    if (!_listners) {
        _listners = [NSPointerArray weakObjectsPointerArray];
    } else {
        [_listners compact];
    }
    return _listners;
}
@end

@implementation PCMessage

- (instancetype)initWithMessageType:(PCMessageType)type content:(id)content {
    self = [super init];
    if (self) {
        _type = type;
        _content = content;
    }
    return self;
}

@end
