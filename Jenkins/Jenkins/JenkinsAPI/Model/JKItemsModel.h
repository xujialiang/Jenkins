//
//  JKItemsModel.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"
#import "JKAuthorModel.h"

@interface JKItemsModel : JKBaseModel

@property (nonatomic,strong) NSArray *affectedPaths;
@property (nonatomic,strong) NSString *commitId;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) JKAuthorModel *author;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *msg;

@end
