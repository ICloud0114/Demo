//
//  TBCmds.h
//  tSmartSDK
//
//  Created by Topband on 2018/1/2.
//  Copyright © 2018年 topband. All rights reserved.
//

#ifndef TBCmds_h
#define TBCmds_h
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TBCLOUD_CMD) {

    TOPBAND_CMD_SN = 20, // set nickname 20
    TOPBAND_CMD_MP = 21, // modify password 21
    TOPBAND_CMD_QD = 27, // query data (27)查询表数据
    TOPBAND_CMD_GC = 30, //get code(30) 获取验证码
    //    TOPBAND_CMD_GSC = 49, //get sms code 49
    //    TOPBAND_CMD_CSC = 50, //check sms code 50
    TOPBAND_CMD_RST = 31, //register 31
    TOPBAND_CMD_RESETPASSWORD = 32, //重置用户密码接口  reset password
    TOPBAND_CMD_IP = 37, //info push (37) 消息推送
    TOPBAND_CMD_TR = 38, //token report(38)token上报
    TOPBAND_CMD_UHI = 41,  //upload head image(41) 用户头像上传
    TOPBAND_CMD_CLO = 43, // client logout (43) 客户端退出登录
    TOPBAND_CMD_AMOA = 44,  //account modify or add(44) 账号修改或新增
    TOPBAND_CMD_QDUOD = 45,  //query data up or down(45) 查询表数据,上拉或者下拉
    TOPBAND_CMD_UDN = 46,  //update device name(46)  //修改设备信息
    TOPBAND_CMD_IPD = 51, //info push_data (51) 消息推送(只推送数据的)
    
    TOPBAND_CMD_BD = 5, // bind device 5
    TOPBAND_CMD_GTP = 24,   // get temporary password (24) 获取临时开锁密码
    TOPBAND_CMD_CTP = 25,   // cancel    temporary password (25) 取消临时开锁密码
    TOPBAND_CMD_DU = 26,   // delete user (26) APP 删除用户
    TOPBAND_CMD_BDS = 29,   //bind device status (29) 绑定门锁状态返回
    TOPBAND_CMD_DINVITE = 36, //device invite 设备分享
    TOPBAND_CMD_DHC = 39, //device share confirm(39) 分享设备确认
    TOPBAND_CMD_RLR = 40,  //report lock remind(40) 门锁开门提醒设置
    TOPBAND_CMD_AUDD = 47, //app user delete device (47)  //app 用户删除设备
    TOPBAND_CMD_LOCK_RESET = 50,  //lock reset (50)  门锁恢复出厂设置
    TOPBAND_CMD_FIRMWARE_UPDATE = 57, // firmware update (57)固件升级
    TOPBAND_CMD_READED_MESSAGE_NUM = 58,//消息通知已读
    TOPBAND_CMD_UPLOAD_LOCK_USER_NAME = 62, //更改锁的用户名
    TOPBAND_CMD_USUN = 63, //分享用户昵称
    TOPBAND_CMD_GFUC = 64, //get firmware upgrad code (64)获取固件升级验证码
    TOPBAND_CMD_BFC = 72, //bind device(72) 绑定亲情卡
    TOPBAND_CMD_GFCU = 73, //get card users(73) 获取亲情卡下监护人
    TOPBAND_CMD_UDFCP = 74, //update card phone(74) 添加亲情卡监护人
    TOPBAND_CMD_UBFC = 75,//unbind device(75) 解绑亲情卡
    TOPBAND_CMD_DFCP = 76//delete card phone(76) 删除亲情卡监护人

};

#endif /* TBCmds_h */
