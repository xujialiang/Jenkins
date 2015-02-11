//
//  JKJobHistoryRequestDTO.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKJobHistoryRequestDTO.h"
#import "JKHistoryJobDetailModel.h"
#import "JKCausesModel.h"

@implementation JKJobHistoryRequestDTO

-(id)getResponseByData:(id)data{
    JKHistoryJobDetailModel *model = [[JKHistoryJobDetailModel alloc] init];
    [model Parse:data];
    
    
    return model;
}

@end
