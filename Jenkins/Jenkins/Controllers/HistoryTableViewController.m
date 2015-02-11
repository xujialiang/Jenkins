//
//  HistoryTableViewController.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "AFNetworking.h"
#import "ProjectHelper.h"
#import "CXAlertView.h"
#import "MBProgressHUD.h"

@interface HistoryTableViewController ()

@property (nonatomic,strong) NSArray *plistData;

@end

@implementation HistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

-(void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *detail = [ProjectHelper FetchProject:self.projectName];
    NSString *downloadpath = [detail objectForKey:@"download"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    manager.responseSerializer= [AFJSONResponseSerializer serializer];

    [manager GET:downloadpath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.plistData = responseObject;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showError:error];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.plistData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.plistData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"点击安装";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *downloadurl = [ProjectHelper FetchDownloadUrl:[self.plistData objectAtIndex:indexPath.row] projectName:self.projectName];
    NSString *downloadpath = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",downloadurl];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadpath]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
