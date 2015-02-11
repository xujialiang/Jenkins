//
//  JKService.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKService.h"
#import "JKHttpRequest.h"
#import "JKJobsRequestDTO.h"
#import "JKJobDetailRequestDTO.h"
#import "JKJobHistoryRequestDTO.h"

@implementation JKService

+(id)sharedJKService{
    static JKService *sharedJKService;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^ {
        sharedJKService = [[JKService alloc] init];
    });
    
    return sharedJKService;
}

-(void)setJenkinsServer:(NSString *)server{
    if ([server hasSuffix:@"/"]) {
        self.server=server;
    }else{
        self.server = [server stringByAppendingString:@"/"];
    }
}

-(void)FetchAllJobs:(ServiceDidFinished)finishedCallBack{
    JKHttpRequest *req = [[JKHttpRequest alloc] init];
    
    JKJobsRequestDTO *dto =[[JKJobsRequestDTO alloc] initWithUrl:[self getRequestUrl:nil] httpMethod:HttpMethodGet paramDic:nil];
    
    [req startRequest:dto finished:^(JKBaseRequestDTO *req, id resp, NSError *err) {
        finishedCallBack(resp,err);
    }];
}

-(void)FetchJobDetail:(JKJobsModel *)model finished:(ServiceDidFinished)finishedCallBack{
    JKHttpRequest *req = [[JKHttpRequest alloc] init];
    JKJobDetailRequestDTO *dto = [[JKJobDetailRequestDTO alloc] initWithUrl:[model.url stringByAppendingString:@"api/json?pretty=true"]httpMethod:HttpMethodGet paramDic:nil];
    
    [req startRequest:dto finished:^(JKBaseRequestDTO *req, id resp, NSError *err) {
        finishedCallBack(resp,err);
    }];
}

-(void)FetchJobHistoryDetail:(JKBuildsModel *)model finished:(ServiceDidFinished)finishedCallBack{
    JKHttpRequest *req = [[JKHttpRequest alloc] init];
    JKJobHistoryRequestDTO *dto = [[JKJobHistoryRequestDTO alloc] initWithUrl:[model.url stringByAppendingString:@"api/json?pretty=true"]httpMethod:HttpMethodGet paramDic:nil];
    
    [req startRequest:dto finished:^(JKBaseRequestDTO *req, id resp, NSError *err) {
        finishedCallBack(resp,err);
    }];
}


-(NSString *)getRequestUrl:(NSString *)mehotd{
    if (mehotd==nil) {
        NSString *requesturl = [NSString stringWithFormat:@"%@api/json?pretty=true",self.server];
        return requesturl;
    }else{
        NSString *requesturl = [NSString stringWithFormat:@"%@%@/api/json?pretty=true",self.server,mehotd];
        return requesturl;
    }
    
}
@end
