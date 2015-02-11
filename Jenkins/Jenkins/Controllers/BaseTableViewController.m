//
//  BaseTableViewController.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CXAlertView.h"
#import "MBProgressHUD.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    CGRect frame = self.tableView.tableHeaderView.frame;
    frame.size.height = 10;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.tableView setTableHeaderView:headerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showError:(NSError *)error{
    CXAlertView *alertview = [[ CXAlertView alloc] initWithTitle:@"出错啦~" message:error.localizedDescription cancelButtonTitle:@"知道了"];
    [alertview show];
}

-(void)showLoading{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)hideLoading{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
@end
