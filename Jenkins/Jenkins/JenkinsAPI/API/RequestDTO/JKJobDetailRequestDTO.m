//
//  JKJobDetailRequestDTO.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKJobDetailRequestDTO.h"
#import "JKJobDetailModel.h"

@implementation JKJobDetailRequestDTO

-(id)getResponseByData:(id)data{
    JKJobDetailModel *model = [[JKJobDetailModel alloc] init];
    [model Parse:data];
    
    return model;
}

@end
