//
//  JKJobDetailModel.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"

@interface JKJobDetailModel : JKBaseModel

@property (nonatomic,strong) NSString *displayName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSNumber *buildable;
@property (nonatomic,strong) NSArray *builds;
@property (nonatomic,strong) NSArray *healthReport;
@property (nonatomic,strong) NSArray *upstreamProjects;
@property (nonatomic,strong) NSNumber *concurrentBuild;
@property (nonatomic,strong) NSString *color;


@end
