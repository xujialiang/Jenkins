//
//  JKBaseModel.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKBaseModel : NSObject

@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSError *error;

-(void)Parse:(NSDictionary *)dataDic;

@end
