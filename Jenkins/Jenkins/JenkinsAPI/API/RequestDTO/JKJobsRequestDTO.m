//
//  JKJobsRequestDTO.m
//  获取Jenkins上任务列表
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKJobsRequestDTO.h"
#import "JKJobsModel.h"

@implementation JKJobsRequestDTO

-(id)getResponseByData:(id)data{
    NSDictionary *dataArr = (NSDictionary *)data;
    NSArray *jobs = [dataArr objectForKey:@"jobs"];
    
    NSMutableArray *responseResult = [[NSMutableArray alloc] init];
    [jobs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JKJobsModel *model = [[JKJobsModel alloc] init];
        [model Parse:obj];
        [responseResult addObject:model];
    }];
        
    return responseResult;
}

@end
