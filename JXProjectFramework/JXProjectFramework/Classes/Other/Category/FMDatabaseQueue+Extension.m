//
//  FMDatabaseQueue+Extension.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "FMDatabaseQueue+Extension.h"

#define DB_PATH [NSString stringWithFormat:@"%@/%@.db", ST_DOCUMENT_DIRECTORY, ST_APP_NAME]

@implementation FMDatabaseQueue (Extension)

+ (instancetype)shareInstense {
    
    static FMDatabaseQueue *queue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 根据路径，创建数据库
        queue = [FMDatabaseQueue databaseQueueWithPath:DB_PATH];
        NSLog(@"DB_PATH == %@",DB_PATH);
    });
    
    return queue;
}



@end
