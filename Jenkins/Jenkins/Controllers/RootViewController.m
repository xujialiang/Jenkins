//
//  RootViewController.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "RootViewController.h"
#import "ProjectHelper.h"
#import "JobDescViewController.h"
#import "HistoryTableViewController.h"
#import "SWTableViewCell.h"
#import "AddProjectViewController.h"

@interface RootViewController ()<SWTableViewCellDelegate>

@property (nonatomic,strong) NSMutableDictionary *projectList;
@property (nonatomic,strong) NSString *selectedProjectName;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void)loadData{
    NSDictionary *dics = [ProjectHelper FetchAllProjects];
    self.projectList = [dics mutableCopy];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender{
    if ([segue.identifier isEqualToString:@"sid_history"]) {
        HistoryTableViewController *history = segue.destinationViewController;
        history.projectName = self.selectedProjectName;
    }else if ([segue.identifier isEqualToString:@"sid_root2config"]){
        AddProjectViewController *job = segue.destinationViewController;
        job.projectName = self.selectedProjectName;
    }
    else if ([segue.identifier isEqualToString:@"sid_root2status"]){
        JobDescViewController *job = segue.destinationViewController;
        job.projectName = self.selectedProjectName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.projectList.allKeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;

    NSString *key = self.projectList.allKeys[indexPath.row];
    cell.textLabel.text = [ProjectHelper projectWithNoPrefix:key];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedProjectName = [self.projectList.allKeys objectAtIndex:indexPath.row];
    NSDictionary *result = [ProjectHelper FetchProject:self.selectedProjectName];

    if ([[result objectForKey:@"download"] isEqualToString:@""]) {
        [self showError:[NSError errorWithDomain:@"未配置IPA 部署服务器地址" code:-1000 userInfo:nil]];
    }else{
        [self performSegueWithIdentifier:@"sid_history" sender:self];
    }
    
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [cell hideUtilityButtonsAnimated:YES];
            self.selectedProjectName = [self.projectList.allKeys objectAtIndex:[self.tableView indexPathForCell:cell].row];
            [self performSegueWithIdentifier:@"sid_root2status" sender:self];
            break;
        }
        case 1:
        {
            [cell hideUtilityButtonsAnimated:YES];
            self.selectedProjectName = [self.projectList.allKeys objectAtIndex:[self.tableView indexPathForCell:cell].row];
            [self performSegueWithIdentifier:@"sid_root2config" sender:self];
            break;
        }
        case 2:
        {
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            [self.projectList removeObjectForKey:self.projectList.allKeys[cellIndexPath.section]];
            [ProjectHelper DelProject:self.projectList.allKeys[cellIndexPath.section]];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}



- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor blueColor]
                                                title:@"状态"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"配置"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}
@end
