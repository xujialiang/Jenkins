//
//  BaseTableViewController.h
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController


-(void)showError:(NSError *)err;

-(void)showLoading;
-(void)hideLoading;
@end
