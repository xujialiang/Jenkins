//
//  ProjectHelper.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "ProjectHelper.h"

@implementation ProjectHelper

+(void)AddProject:(NSString *)projectName Desc:(NSDictionary *)desc{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:desc forKey:[ProjectHelper projectWithPrefix:projectName]];
}

+(void)DelProject:(NSString *)projectName{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes removeObjectForKey:projectName];
}
+(void)UpdaeProject:(NSString *)projectName Desc:(NSDictionary *)desc{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:desc forKey:[ProjectHelper projectWithPrefix:projectName]];
}
+(NSDictionary *)FetchProject:(NSString *)projectName{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    return  [userDefaultes dictionaryForKey:projectName];
}
+(NSDictionary *)FetchAllProjects{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic =[[userDefaultes dictionaryRepresentation] mutableCopy];
    [dic.allKeys enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (![obj hasPrefix:@"CI_"]) {
            [dic removeObjectForKey:obj];
        }
    }];
    
    return dic;
}

+(NSString *)FetchDownloadUrl:(NSString *)plistName projectName:(NSString *)name{
    NSDictionary *dic = [ProjectHelper FetchProject:name];
    NSString *str = [dic objectForKey:@"download"];
    
    NSArray *patharr = [str componentsSeparatedByString:@"/"];
    NSString *newpath = [NSString stringWithFormat:@"%@//%@/download/%@/plist/",patharr[0],patharr[2],patharr[3]];
    
    if ([newpath hasSuffix:@"/"]) {
        return [newpath stringByAppendingString:plistName];
    }else{
        return [[newpath stringByAppendingString:@"/"] stringByAppendingString:plistName];
    }
    
}

+(NSString *)projectWithNoPrefix:(NSString *)projectName{
    return [projectName substringFromIndex:3];
}

+(NSString *)projectWithPrefix:(NSString *)projectName{
    return [NSString stringWithFormat:@"CI_%@",projectName];
}
@end
