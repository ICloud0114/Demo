//
//  EventMessage+TableCoding.m
//  tSmartSDK-SolarEnergy
//
//  Created by Topband on 2018/1/24.
//  Copyright © 2018年 topband. All rights reserved.
//

#import "TBEventMessage+TableCoding.h"
//Field    Type    Comment
//id    varchar(32) NOT NULL    序号
//uid    varchar(24) NULL    网关UID
//device_id    varchar(32) NULL    报警设备编号
//type    int(11) NULL    类型
//time    datetime NULL    报警时间
//message    varchar(200) NULL    内容
//read_type    int(11) NULL    是否已读,0-未读，1-已读
//update_time    datetime NULL    修改时间
//create_time    datetime NULL    创建时间
//del_flag    int(11) NULL    删除标志，0：表示正常使用的数据 1：表示已删除的数据
//device_event_id    varchar(32) NULL    设备端事件id
@implementation TBEventMessage (TableCoding)

+ (BOOL)createTable {
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS %@ "
                     "(id TEXT,"
                     "uid TEXT,"
                     "device_id TEXT,"
                     "type INTEGER,"
                     "time TEXT,"
                     "message TEXT,"
                     "read_type INTEGER,"
                     "update_time TEXT,"
                     "create_time TEXT,"
                     "del_flag INTEGER,"
                     "device_event_id TEXT,"
                     "read_status INTEGER DEFAULT 0," //额外属性,记录当前消息是否已读
                     "UNIQUE(id) ON CONFLICT REPLACE)", [self tableName]];
    return executeUpdate(sql);
}

- (BOOL)insertObject {
    return [self insertObjectWithDb:[TBDatabaseManager shareInstance].db];
}

- (NSString *)prepareSql {
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO %@ "
                     "("
                     "id,"
                     "uid,"
                     "device_id,"
                     "type,"
                     "time,"
                     "message,"
                     "read_type,"
                     "update_time,"
                     "create_time,"
                     "del_flag,"
                     "device_event_id,"
                     "read_status"
                     ") "
                     "VALUES "
                     "("
                     "'%@'," //id
                     "'%@'," //uid
                     "'%@'," //device_id
                     "%d," //type
                     "'%@',"  //time
                     "'%@',"    //message
                     "%d," //read_type
                     "'%@'," //update_time
                     "'%@'," //create_time
                     "%d," //del_flag
                     "'%@'," //device_event_id
                     "%d" //read_status
                     ")",
                     [[self class] tableName],
                     self.id,
                     self.uid,
                     self.deviceId,
                     self.type,
                     self.time,
                     self.message,
                     self.readType,
                     self.updateTime,
                     self.createTime,
                     self.delFalg,
                     self.deviceEventId,
                     self.readStatus];
    return sql;
}

- (BOOL)insertObjectWithDb:(FMDatabase *)db {
    //插入之前，先读取一下当前消息的read_status
    NSString *readStatusSql = [NSString stringWithFormat:
                               @"SELECT read_status AS readStatus FROM %@ WHERE id = '%@'", [[self class] tableName], self.id];
    FMResultSet *set = [db executeQuery:readStatusSql];
    int readStatus = 0;
    if ([set next]) {
        readStatus = [set intForColumn:@"readStatus"];
    }
    [set close];
    self.readStatus = readStatus;

    NSString *sql = [self prepareSql];
    return [db executeUpdate:sql];
}

+ (NSString *)tableName {
    return @"d_event_message";
}

+ (NSString *)maxUpdateTime {
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(update_time) FROM %@", [[self class] tableName]];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MAX(update_time)"];
    });
    return maxUpdateTime;
}

+ (NSString *)minUpdateTime {
    NSString *sql = [NSString stringWithFormat:@"SELECT MIN(update_time) FROM %@", [[self class] tableName]];
    __block NSString *maxUpdateTime = nil;
    queryDatabase(sql, ^(FMResultSet * _Nonnull rs) {
        maxUpdateTime = [rs stringForColumn:@"MIN(update_time)"];
    });
    return maxUpdateTime;
}

@end
