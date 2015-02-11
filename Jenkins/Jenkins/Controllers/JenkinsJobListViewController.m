//
//  JenkinsJobListViewController.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/9.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JenkinsJobListViewController.h"
#import "JKJobsModel.h"
#import "ProjectHelper.h"

@interface JenkinsJobListViewController(){}

@property (nonatomic,strong) NSMutableDictionary *selectedIndex;

@end

@implementation JenkinsJobListViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.jobList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    if ([self.selectedIndex objectForKey:[NSString stringWithFormat:@"%@",indexPath]]!=nil) {
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType= UITableViewCellAccessoryNone;

    }
    
    JKJobsModel *model = self.jobList[indexPath.row];
    cell.textLabel.text =model.name;
    cell.detailTextLabel.text = model.url;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected =YES;
    cell.accessoryType= UITableViewCellAccessoryCheckmark;
    [self.selectedIndex setObject:indexPath forKey:[NSString stringWithFormat:@"%@",indexPath]];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.selected =NO;
    cell.accessoryType= UITableViewCellAccessoryNone;
    [self.selectedIndex removeObjectForKey:[NSString stringWithFormat:@"%@",indexPath]];
}

- (IBAction)DoAddProject:(id)sender {
    
    
    NSArray *selectedIndexPaths = [self.tableView indexPathsForSelectedRows];
    [selectedIndexPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JKJobsModel *model = self.jobList[idx];
        [ProjectHelper UpdaeProject:model.name Desc:@{@"url":model.url,@"download":@""}];
        
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

@end
