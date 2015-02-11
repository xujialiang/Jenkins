//
//  JKHttpRequest.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKHttpRequest.h"
#import "AFNetworking.h"

@implementation JKHttpRequest

-(void)startRequest:(JKBaseRequestDTO *)requestDTO finished:(RequestDidFinished)finished{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    
    [manager GET:requestDTO.APIUrl parameters:requestDTO.paramDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            id result = [requestDTO getResponseByData:responseObject];
            finished(requestDTO,result,nil);
        } else {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        finished(requestDTO,nil,error);
    }];
}

@end
