//
//  JKBaseRequestDTO.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseModel.h"

typedef enum{
    HttpMethodPost = 0,
    HttpMethodGet = 1
}HttpMethod;

@interface JKBaseRequestDTO : JKBaseModel


@property (strong, nonatomic) NSMutableDictionary   *paramDic;
@property (assign, nonatomic)HttpMethod             httpMethod;
@property (strong, nonatomic) NSString              *APIUrl;


-(id)initWithUrl:(NSString *)url httpMethod:(HttpMethod)http paramDic:(NSDictionary *)paramDic;

-(id)getResponseByData:(id)data;

@end
