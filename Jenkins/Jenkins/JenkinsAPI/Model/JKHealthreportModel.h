//
//  JKHealthReportModel.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"

@interface JKHealthreportModel : JKBaseModel

@property (nonatomic,strong,readwrite) NSString *description;
@property (nonatomic,strong) NSString *iconClassName;
@property (nonatomic,strong) NSString *iconUrl;
@property (nonatomic,strong) NSNumber *score;



@end
