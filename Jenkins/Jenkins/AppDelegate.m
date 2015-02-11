//
//  AppDelegate.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/4.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "AppDelegate.h"
#import "JKService.h"
#import "JKJobDetailModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
//    [[JKService sharedJKService] setJenkinsServer:@"http://10.20.73.34:8080"];
//    [[JKService sharedJKService] FetchAllJobs:^(NSArray *resp, NSError *err) {
//        [[JKService sharedJKService] FetchJobDetail:resp[0] finished:^(JKJobDetailModel *resp2, NSError *err2) {
//            [[JKService sharedJKService] FetchJobHistoryDetail:resp2.builds[0] finished:^(id resp, NSError *err) {
//                
//                
//            }];
//        }];
//    }];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
