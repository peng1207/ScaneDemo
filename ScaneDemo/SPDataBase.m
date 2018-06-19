//
//  SPDataBase.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/15.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPDataBase.h"
#import "FMDatabase.h"

static SPDataBase *dataBase = nil;

@interface SPDataBase ()
@property (nonatomic,strong)  FMDatabase *db;

@end

@implementation SPDataBase

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[SPDataBase alloc] init];
    });
    return dataBase;
}

- (void)creatDB{
   NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //设置数据库名称
    NSString *fileName = [docPath stringByAppendingPathComponent:@"project.sqlite"];
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:fileName];
    if ([_db open]) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    
}


@end
