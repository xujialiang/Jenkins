//
//  ProjectHelper.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectHelper : NSObject

+(void)AddProject:(NSString *)projectName Desc:(NSDictionary *)desc;
+(void)DelProject:(NSString *)projectName;
+(void)UpdaeProject:(NSString *)projectName Desc:(NSDictionary *)desc;
+(NSDictionary *)FetchProject:(NSString *)projectName;
+(NSDictionary *)FetchAllProjects;

+(NSString *)FetchDownloadUrl:(NSString *)plistName projectName:(NSString *)name;
+(NSString *)projectWithNoPrefix:(NSString *)projectName;
+(NSString *)projectWithPrefix:(NSString *)projectName;
@end
