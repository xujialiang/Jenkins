//
//  JKBaseModel.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"

#define ModelPrefix @"JK"
#define ModelSurfix @"Model"


@implementation JKBaseModel
@synthesize description;


/**
 *  解析入口
 *
 *  @param dataDic 入口
 */
-(void)Parse:(NSDictionary *)dataDic{
    if (![dataDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    @try {
        [dataDic.allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            if ([[dataDic objectForKey:key] isKindOfClass:[NSString class]]) {
                [JKBaseModel DataParseString:key val:[dataDic objectForKey:key] obj:self];
            }else if ([[dataDic objectForKey:key] isKindOfClass:[NSNumber class]]){
                [JKBaseModel DataParseNumber:key val:[dataDic objectForKey:key] obj:self];
            }else if ([[dataDic objectForKey:key] isKindOfClass:[NSDictionary class]]){
                [JKBaseModel DataParseDictionary:key data:[dataDic objectForKey:key] obj:self];
            }else if ([[dataDic objectForKey:key] isKindOfClass:[NSArray class]] && [[dataDic objectForKey:key] count]>0){
                [JKBaseModel DataParseArray:key data:[dataDic objectForKey:key]  obj:self];
            }
        }];
    }
    @catch (NSException *exception) {
        self.error = [NSError errorWithDomain:@"解析出错" code:-1000 userInfo:nil];
    }
    @finally {
        
    }
}

/**
 *  解析字符串
 *
 *  @param key 键
 *  @param val 值
 *  @param obj Model Instance
 */
+(void)DataParseString:(NSString *)key val:(id)val obj:(id)obj{
    if ([obj respondsToSelector:NSSelectorFromString(key)]) {
        [obj setValue:val forKey:key];
    }
}

/**
 *  解析数字
 *
 *  @param key 键
 *  @param val 值
 *  @param obj Model Instance
 */
+(void)DataParseNumber:(NSString *)key val:(id)val obj:(id)obj{
    if ([obj respondsToSelector:NSSelectorFromString(key)]) {
        [obj setValue:val forKey:key];
    }
}

/**
 *  解析Array
 *
 *  @param key     Model 名
 *  @param dataArr 数据
 *  @param obj     Model Instance
 */
+(void)DataParseArray:(NSString *)key data:(NSArray *)dataArr obj:(id)obj{
    if ([obj respondsToSelector:NSSelectorFromString(key)]) {
        Class class = [JKBaseModel getClassModel:key];
        if (class !=nil) {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [dataArr enumerateObjectsUsingBlock:^(id data, NSUInteger idx, BOOL *stop) {
                id submodel = [[class alloc] init];
                [submodel Parse:data];
                [arr addObject:submodel];
            }];
            [obj setValue:arr forKey:key];
        }
    }
}

/**
 *  解析Dictionary
 *
 *  @param modelName Model名
 *  @param dataDic   Dictionary
 *  @param obj       Model instance
 */
+(void)DataParseDictionary:(NSString *)modelName data:(NSDictionary *)dataDic obj:(id)obj{
    if (![obj respondsToSelector:NSSelectorFromString(modelName)]) {
        return;
    }
    
    Class class = [JKBaseModel getClassModel:modelName];
    if (class !=nil) {
        id model = [[class alloc] init];
        [obj setValue:model forKey:modelName];
        [model Parse:dataDic];
    }
    
}

/**
 *  根据Key获取Model 的Class
 *
 *  @param key Model 的Key
 *
 *  @return Class
 */
+(Class)getClassModel:(NSString *)key{
    NSString *subclassname = key.lowercaseString;
    NSString *subclassname_firstletter = [subclassname substringToIndex:1].uppercaseString;
    NSString *subclassname_otherletters = [subclassname substringFromIndex:1].lowercaseString;
    NSString *submodel_fullname = [NSString stringWithFormat:@"%@%@%@%@",ModelPrefix,subclassname_firstletter,subclassname_otherletters,ModelSurfix];
    Class class = NSClassFromString(submodel_fullname);
    return class;
}


@end
