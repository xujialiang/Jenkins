//
//  JKHttpRequest.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/7.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKBaseRequestDTO.h"

@interface JKHttpRequest : NSObject

typedef void(^RequestDidFinished)(JKBaseRequestDTO *req, id resp,NSError *err);


-(void)startRequest:(JKBaseRequestDTO *)requestDTO finished:(RequestDidFinished)finished;


@end
