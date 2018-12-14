//
//  TBReadTableTask.m
//  tSmartSDK
//
//  Created by Topband on 2017/12/19.
//  Copyright © 2017年 topband. All rights reserved.
//

#import "TBReadTableTask.h"
#import "TBQueryDataCmd.h"
#import <MJExtension/MJExtension.h>
#import <TBDataBase/TBDatabaseManager.h>
#import <TBDataBase/TBTableCoding.h>
#import <TBDataBase/NSUserDefaults+Cache.h>

@interface TBReadTableTask() {
}

@property (nonatomic, strong) TBQueryDataCmd *readTableCmd;
@property (nonatomic, assign) int totalPage; //当前读表任务的总页数
@property (nonatomic, strong) NSMutableArray *readPages; //已读页的下标
@property (nonatomic, strong) NSMutableArray *savedPages; //已保存完成页的下标

@property (nonatomic, assign) int updateTimeSec;
@property (nonatomic, assign, readonly, getter=isFinished) BOOL finished;

@property (nonatomic, assign) int readTableLostPageSerial; //记录当前读丢失页时的serial
@property (nonatomic, assign) int tryTimes; //读表重发次数

@end

@implementation TBReadTableTask

- (void)execute {
    [self readTable];
}

- (void)readTable {
    NSDictionary *tableInfo = [self tableInfoWithUserId:self.userId deviceId:self.deviceId uid:self.uid];
    [self cancelTimeoutWithReadTableInfo:tableInfo];
    [self addTimeoutWithReadTableInfo:tableInfo];
    self.tryTimes += 1;
    sendCmd(self.readTableCmd, ^(TBResponse *response) {
        if (response.status == TBStatusSuccess) {
            DLog(@"读取表%@命令成功", self.tableName);
        } else {
            DLog(@"读表%@命令失败，状态么：%@", self.tableName, @(response.status));
        }
    });
}

- (NSString *)updateTimeSecKey {
    NSString *lastUpdateTimeSecKey = nil;
    NSString *DATABASE_VERSION = [TBDatabaseManager version];
    if (self.deviceId) {
        lastUpdateTimeSecKey = [NSString stringWithFormat:@"UpdateTimeSecKey_%@_%@_%@_%@",
                                          self.userId, self.deviceId, self.tableName, DATABASE_VERSION];
    } else if (self.uid && self.uid.length > 0) {
        lastUpdateTimeSecKey = [NSString stringWithFormat:@"UpdateTimeSecKey_%@_%@_%@_%@",
                                self.userId, self.uid, self.tableName, DATABASE_VERSION];
    } else {
        lastUpdateTimeSecKey = [NSString stringWithFormat:@"UpdateTimeSecKey_%@_%@_%@",
                                self.userId, self.tableName, DATABASE_VERSION];
    }
    return lastUpdateTimeSecKey;
}

- (void)didDealWithPage:(NSDictionary *)dic {
    NSNumber *page = [dic objectForKey:@"pageIndex"];
    NSNumber *tPage = [dic objectForKey:@"tPage"];
    if (tPage) {
        self.totalPage = [tPage intValue];
    }
    if (self.totalPage == 0) {
        [self.readPages removeAllObjects];
        return;
    }
    DLog(@"读表<%@>接收到<%@>页包总共<%d>页", self.tableName, page, self.totalPage);
    if (![self.readPages containsObject:page]) {
        DLog(@"读表<%@>的<%@>页添加到数组", self.tableName, page);
        [self.readPages addObject:page];
    }
}

- (void)didDealSavedPageWithPage:(NSNumber *)page {
    if (self.totalPage == 0) {
        [self.savedPages removeAllObjects];
        return;
    }
    if (![self.savedPages containsObject:page]) {
        [self.savedPages addObject:page];
    }
}

//判断当前任务是否已经接受到最后一页数据
- (BOOL)isReceivedLastPage {
    if (self.totalPage == 0) {
        return YES;//没有数据
    }
    // PageIndex 从0开始
    NSNumber *lastPage = @(self.totalPage - 1);
    return [self.readPages containsObject:lastPage];
}

//更新读表时间
- (void)updateReadTableTime:(NSString *)updateTime {
    if (updateTime) {
        int updateTimeSec = secondWithDataValue(updateTime);
        if (updateTimeSec > self.updateTimeSec) {
            self.updateTimeSec = updateTimeSec;
        }
    }
}

- (void)saveTable:(NSString *)tableN data:(NSArray *)arr completion:(void (^)(void))handler {
    Class<TBTableCoding> tableClass = [[TBDatabaseManager shareInstance].tableModelMaps objectForKey:tableN];
    NSMutableArray<id<TBTableCoding>> *tableModels = @[].mutableCopy;
    for (NSDictionary *dic in arr) {
//        [self updateReadTableTime:dic[@"updateTime"]];
        id<TBTableCoding> obj = [tableClass performSelector:@selector(mj_objectWithKeyValues:) withObject:dic];
        if (obj) {
            [tableModels addObject:obj];
        }
    }
    //获取最大时间
    NSString *maxUpdateTime = [arr valueForKeyPath:@"@max.updateTime"];
    [self updateReadTableTime:maxUpdateTime];
//    if ([self isReceivedLastPage] && self.isFinished) {
//        [self saveUpdateTime];
//    }
//    __weak typeof(self) weakSelf = self;
    inTransaction(^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        [tableModels enumerateObjectsUsingBlock:^(id<TBTableCoding>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL result = [obj insertObjectWithDb:db];
            if (!result) {
                *rollback = YES;
            }
        }];
        dispatch_async_main(handler);
    });
}

- (void)saveTableData:(NSDictionary *)data {
    NSArray *tableNameList = [data objectForKey:@"tableNameList"];
    if (!(tableNameList.count > 0)) {
        DLog(@"读表%@,返回了空的数据😢", self.tableName);
        return;
    }
    __weak typeof(self) weakSelf = self;
    inSerialQueue(^{
        for (int index = 0; index < tableNameList.count; ++index) {
            @autoreleasepool {
                NSString *tn = tableNameList[index];
                [weakSelf saveTable:tn data:data[tn] completion:^{
                    DLog(@"第%@页保存完第%d帧", [data objectForKey:@"pageIndex"], index);
                    if (index == tableNameList.count - 1) {
                        NSNumber *page = [data objectForKey:@"pageIndex"];
                        DLog(@"第%@页保存完成", page);
                        [weakSelf didDealSavedPageWithPage:page];
                    }
                }];
            }
        }
    });
}

//获取丢失的页
- (NSArray *)lostPages {
    if (!self.isFinished) {
        NSMutableArray *allPageArr = [NSMutableArray array];
        for (int i = 0; i < self.totalPage; i ++) {
            [allPageArr addObject:@(i)];
        }
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"NOT self in %@",self.readPages];
        NSArray *array = [allPageArr filteredArrayUsingPredicate:pred];
        DLog(@"读表%@丢失掉的页：%@", self.tableName, array);
        return array;
    }
    return nil;
}

//从新获取丢失页的数据
- (void)reloadLostPageData {
    NSDictionary *tableInfo = [self tableInfoWithUserId:self.userId deviceId:self.deviceId uid:self.uid];
    [self cancelTimeoutWithReadTableInfo:tableInfo];
    [self addTimeoutWithReadTableInfo:tableInfo];
    TBQueryDataCmd *cmd = [self readLostTableCmd];
    if (cmd) {
        __weak typeof(self) weakSelf = self;
        sendCmd(cmd, ^(TBResponse *response) {
            int serial = [[response.result objectForKey:@"serial"] intValue];
            if (response.status == TBStatusSuccess) {
                DLog(@"表%@度丢失成功, 流水号:%d", [weakSelf tableName], serial);
                weakSelf.readTableLostPageSerial = serial;
            } else {
                DLog(@"表%@度丢失失败, 流水号:%d", [weakSelf tableName], serial);
            }
        });
    }
}

- (void)saveUpdateTime {
    NSString *key = [self updateTimeSecKey];
    UserDefaultsSave(key, @(self.updateTimeSec));
    DLog(@"读表%@成功---更新updateTimeSec: %d, key: %@", self.tableName, self.updateTimeSec, key);
}

//读表成功清理函数
- (void)didReadTableSuccess {
    DLog(@"读表%@成功---%f", self.tableName, CFAbsoluteTimeGetCurrent());
//    [self saveUpdateTime];
    __weak typeof(self) weakSelf = self;
//    CGFloat delay = self.readPages.count / 2 * 0.1;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        DLog(@);
//        DLog(@"读表%@成功-开始上报---%f", self.tableName, CFAbsoluteTimeGetCurrent());
//        [weakSelf.delegate didReadTableSuccess:weakSelf];
//
//    });
    dispatch_queue_t queue = dispatch_queue_create("com.topband.readTable", NULL);
    dispatch_async(queue, ^{
        while (![self isSaveFinished]) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        DLog(@"读表%@成功-开始上报---%f", self.tableName, CFAbsoluteTimeGetCurrent());
        [self saveUpdateTime];
        [weakSelf.delegate didReadTableSuccess:weakSelf];
    });
}

- (void)didReceiveReadTablePayload:(NSDictionary *)payload {
    NSDictionary *data = [payload objectForKey:@"data"];
    NSString *userId = [payload objectForKey:@"userId"];
    NSString *deviceId = [payload objectForKey:@"deviceId"];
    NSString *uid = [payload objectForKey:@"uid"];
    NSDictionary *tableInfo = [self tableInfoWithUserId:userId deviceId:deviceId uid:uid];
    //没接收到一页数据就先取消定时，数据处理完后判断是否还有未接收页的话就在添加等待超时
    [self cancelTimeoutWithReadTableInfo:tableInfo];
    //先处理页
    [self didDealWithPage:data];
    //保存当前接受到数据到数据库
    [self saveTableData:data];
    //判断当前读表任务最后一页是否获取到
    if ([self isReceivedLastPage]) {
        if (self.isFinished) { //当前任务读表完成
            [self didReadTableSuccess];
        } else { //最后一页数据获取到了，但是中间有丢失页
            [self reloadLostPageData];
        }
    } else { //接受到某页数据但是判断不是最后一页的话，则添加超时机制继续等待
        [self addTimeoutWithReadTableInfo:tableInfo];
    }
}

- (void)didRecevieReadTableTimeout:(NSDictionary *)tableInfo {
    if (self.tryTimes < 2) {
        DLog(@"尝试读表%d次", self.tryTimes);
        [self readTable];
    } else {
        DLog(@"读表超时");
        [self.delegate readTableTask:self didReadTableFailed:[[TBResponse alloc] initWithStatus:TBStatusTimeout result:tableInfo]];
    }
}

#pragma mark - timeout
- (void)addTimeoutWithReadTableInfo:(NSDictionary *)tableInfo {
    if ([NSThread currentThread].isMainThread) {
        [self performSelector:@selector(didRecevieReadTableTimeout:) withObject:tableInfo afterDelay:5];
    } else {
        __weak typeof(self) weakSelf = self;
        dispatch_async_main(^{
            [weakSelf performSelector:@selector(didRecevieReadTableTimeout:) withObject:tableInfo afterDelay:5];
        });
    }
}

- (void)cancelTimeoutWithReadTableInfo:(NSDictionary *)tableInfo {
    if ([NSThread currentThread].isMainThread) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didRecevieReadTableTimeout:) object:tableInfo];
    } else {
        __weak typeof(self) weakSelf = self;
        dispatch_async_main(^{
            [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(didRecevieReadTableTimeout:) object:tableInfo];
        });
    }
}

#pragma mark - Action
- (void)asyncReceiveDataNotification:(NSNotification *)notification {
    NSNumber *cmd = notification.object;
    if (cmd.integerValue != 27) { return; }
    NSDictionary *payload = notification.userInfo;
    int serial = [[payload objectForKey:@"serial"] intValue];
    if (self.readTableCmd.serialNo == serial ||
        serial == self.readTableLostPageSerial) { //当前接受数据是当前任务所需数据
        [self didReceiveReadTablePayload:payload];
    }
}

+ (instancetype)instanceWithTableName:(NSString *)tableName uid:(NSString *)uid deviceId:(NSString *)deviceId userId:(NSString *)userId {
    TBReadTableTask *task = [TBReadTableTask new];
    task.tableName = tableName;
    task.uid = uid;
    task.deviceId = deviceId;
    task.userId = userId;
    return task;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(asyncReceiveDataNotification:) name:NOTIFICATION_ASYNC_RECEIVE_DATA object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_ASYNC_RECEIVE_DATA object:nil];
}

#pragma mark - getter setter
//是否保存完成
- (BOOL)isSaveFinished {
    return self.savedPages.count == self.totalPage;
}

- (BOOL)isFinished {
    return self.readPages.count == self.totalPage;
}

- (NSDictionary *)tableInfoWithUserId:(NSString *)userId deviceId:(NSString *)deviceId uid:(NSString *)uid {
    NSMutableDictionary *tableInfo = @{@"userId": userId,
                                       @"tableName": self.tableName,
                                       }.mutableCopy;
    if (deviceId) {
        [tableInfo setObject:deviceId forKey:@"deviceId"];
    }
    if (uid) {
        [tableInfo setObject:uid forKey:@"uid"];
    }
    return tableInfo;
}

- (TBQueryDataCmd *)readTableCmd {
    if (!_readTableCmd) {
        _readTableCmd = [TBQueryDataCmd cmdInstance];
        _readTableCmd.uid = self.uid;
        _readTableCmd.deviceId = self.deviceId;
        _readTableCmd.tableName = self.tableName;
        _readTableCmd.pageIndex = 0;
        _readTableCmd.updateTime = secondWithDataValue(UserDefaultsValue([self updateTimeSecKey]));
    }
    return _readTableCmd;
}

- (TBQueryDataCmd *)readLostTableCmd {
    NSArray *lostPages = [self lostPages];
    if (lostPages.count > 0) {
        TBQueryDataCmd *lostCmd = [TBQueryDataCmd cmdInstance];
        lostCmd.uid = self.uid;
        lostCmd.deviceId = self.deviceId;
        lostCmd.tableName = self.tableName;
        lostCmd.pageIndex = [[lostPages firstObject] intValue];
        return lostCmd;
    }
    return nil;
}

- (NSMutableArray *)completionBlocks {
    if (!_completionBlocks) {
        _completionBlocks = @[].mutableCopy;
    }
    return _completionBlocks;
}

- (NSMutableArray *)readPages {
    if (!_readPages) {
        _readPages = @[].mutableCopy;
    }
    return _readPages;
}

- (NSMutableArray *)savedPages {
    if (!_savedPages) {
        _savedPages = @[].mutableCopy;
    }
    return _savedPages;
}

- (int)updateTimeSec {
    if (_updateTimeSec == 0) {
        _updateTimeSec = secondWithDataValue(UserDefaultsValue([self updateTimeSecKey]));
    }
    return _updateTimeSec;
}

@end

