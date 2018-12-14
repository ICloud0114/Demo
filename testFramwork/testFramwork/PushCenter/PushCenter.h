//
//  PushCenter.h
//  tSmartSDK
//
//  Created by Topband on 2017/12/20.
//  Copyright © 2017年 topband. All rights reserved.
//
// 整个云sdk可用此组件进行模块，层之间的消息发送和监听

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, PCMessageType) {
    PCMessageTypeBindDeviceStatus = (1 << 0), //设备绑定状态返回
    PCMessageTypeUserLogout = (1 << 1), //用户登出
    PCMessageTypeUserLoginSuccess = (1 << 2), //用户登录成功
    PCMessageTypeServerInfoPush = (1 << 3), //用户消息推送
    PCMessageTypeQueryData = (1 << 4), //数据表查询
    PCMessageTypeUnbind = (1 << 5), //设备解绑
    PCMessageTypeServerInfoPushData = (1 << 6), //服务器推送数据同步
    PCMessageTypeLocalDataUpdate = (1 << 7), //本地数据更新
    PCMessageTypeFirewareUpdate = (1 << 8), //固件升级进度
    PCMessageTypeAll = PCMessageTypeBindDeviceStatus | PCMessageTypeUserLogout | PCMessageTypeUserLoginSuccess | PCMessageTypeServerInfoPush | PCMessageTypeQueryData | PCMessageTypeUnbind | PCMessageTypeServerInfoPushData | PCMessageTypeLocalDataUpdate |PCMessageTypeFirewareUpdate
};

@interface PCMessage: NSObject

- (instancetype)initWithMessageType:(PCMessageType)type content:(_Nullable id)content;
@property (nonatomic, assign) PCMessageType type;
@property (nonatomic, nullable, strong) id content;
@end

@class PushCenter;
@protocol PushCenterDelegate <NSObject>

@property (nonatomic, assign, readonly) PCMessageType expectMessage;
- (void)pushCenter:(PushCenter *)pc didReceiveMessage:(PCMessage *)msg;

@end

@interface PushCenter : NSObject

+ (instancetype)share;

- (void)registerListner:(id<PushCenterDelegate>)listner;

- (void)pushMessage:(PCMessage *)message;
@end
NS_ASSUME_NONNULL_END
