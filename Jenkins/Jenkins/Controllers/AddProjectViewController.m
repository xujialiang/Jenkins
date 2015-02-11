//
//  AddProjectViewController.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "AddProjectViewController.h"
#import "ProjectHelper.h"

@interface AddProjectViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt_projectName;
@property (weak, nonatomic) IBOutlet UITextField *txt_projectPath;
@property (weak, nonatomic) IBOutlet UITextField *txt_downloadPath;

@end

@implementation AddProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   NSDictionary *result = [ProjectHelper FetchProject:self.projectName];
    self.txt_projectName.text = [ProjectHelper projectWithNoPrefix:self.projectName];
    self.txt_projectPath.text = [result objectForKey:@"url"];
    self.txt_downloadPath.text = [result objectForKey:@"download"];
}

- (IBAction)saveAction:(id)sender {
    if ([self.txt_projectPath.text isEqualToString:@""] || [self.txt_projectName.text isEqualToString:@""]) {
        return;
    }else{
        [ProjectHelper UpdaeProject:self.txt_projectName.text Desc:@{@"url":self.txt_projectPath.text,@"download":self.txt_downloadPath.text}];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
