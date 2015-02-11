//
//  JKCausesModel.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"

@interface JKCausesModel : JKBaseModel

@property (nonatomic,strong) NSString *shortDescription;
@property (nonatomic,strong) NSNumber *upstreamBuild;
@property (nonatomic,strong) NSString *upstreamProject;
@property (nonatomic,strong) NSString *upstreamUrl;

@end
