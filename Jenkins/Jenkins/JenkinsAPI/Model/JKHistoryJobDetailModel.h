//
//  JKHistoryJobDetail.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"
#import "JKAuthorModel.h"
#import "JKChangesetModel.h"

@interface JKHistoryJobDetailModel : JKBaseModel

@property (nonatomic,strong) NSNumber *building;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSNumber *duration;
@property (nonatomic,strong) NSNumber *estimatedDuration;
@property (nonatomic,strong) NSString *executor;
@property (nonatomic,strong) NSString *fullDisplayName;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSNumber *number;
@property (nonatomic,strong) NSString *result;
@property (nonatomic,strong) NSNumber *timestamp;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *builtOn;
@property (nonatomic,strong) NSArray *actions;
@property (nonatomic,strong) JKChangesetModel *changeSet;

@end
