//
//  JKBaseRequestDTO.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JKBaseRequestDTO.h"

@implementation JKBaseRequestDTO

-(id)initWithUrl:(NSString *)url httpMethod:(HttpMethod)http paramDic:(NSDictionary *)paramDic{
    if(self = [super init]){
        self.APIUrl = url;
        self.httpMethod = http;
        self.paramDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(id)getResponseByData:(id)dataDic{
    return nil;
}

-(void)dealloc{
    NSLog(@"==========%@ dealloc======",[[self class] debugDescription]);
}

@end
