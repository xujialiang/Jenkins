//
//  JKService.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKJobsModel.h"
#import "JKBuildsModel.h"

@interface JKService : NSObject

@property (nonatomic,strong) NSString *server;

typedef void(^ServiceDidFinished)(id resp,NSError *err);

+(id)sharedJKService;

-(void)setJenkinsServer:(NSString *)server;

-(void)FetchAllJobs:(ServiceDidFinished)finishedCallBack;

-(void)FetchJobDetail:(JKJobsModel *)model finished:(ServiceDidFinished)finishedCallBack;

-(void)FetchJobHistoryDetail:(JKBuildsModel *)model finished:(ServiceDidFinished)finishedCallBack;

@end
