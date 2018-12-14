//
//  TBNotice+Extension.h
//  Topband-SolarEnergy-SDK
//
//  Created by Topband on 2018/4/18.
//  Copyright © 2018年 Ramon. All rights reserved.
//

#import "TBNotice.h"

@interface TBNotice (Extension)

- (BOOL)readMsg;

@property (nonatomic, assign, class) int pageSize;

+ (NSArray<TBNotice *> *)readNoticesWithPageIndex:(int)pageIndex;
@end
