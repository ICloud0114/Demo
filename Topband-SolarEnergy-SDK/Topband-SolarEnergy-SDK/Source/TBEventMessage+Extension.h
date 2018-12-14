//
//  TBEventMessage+Extension.h
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBEventMessage.h"

@interface TBEventMessage (Extension)

- (BOOL)readMsg;

@property (nonatomic, assign, class) int pageSize;

+ (NSArray<TBEventMessage *> *)readEventMessagesWithPageIndex:(int)pageIndex;
@end
