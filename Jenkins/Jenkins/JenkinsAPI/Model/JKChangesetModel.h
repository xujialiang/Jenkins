//
//  JKChangeSetModel.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"

@interface JKChangesetModel : JKBaseModel

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) NSString *kind;

@end
