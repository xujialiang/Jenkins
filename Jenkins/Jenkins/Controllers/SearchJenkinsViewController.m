//
//  SearchJenkinsViewController.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/9.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "SearchJenkinsViewController.h"
#import "JKService.h"
#import "JenkinsJobListViewController.h"

@interface SearchJenkinsViewController ()

@property (nonatomic,strong) NSArray *searchResult;

@end

@implementation SearchJenkinsViewController
- (IBAction)DoSearchAction:(id)sender {
    if ([self.txt_server_url.text isEqualToString:@""]) {
        [self showError:[NSError errorWithDomain:@"未填写服务器地址" code:-1000 userInfo:nil]];
    }else{
        
        [self showLoading];
        
        [[JKService sharedJKService] setJenkinsServer:self.txt_server_url.text];
        [[JKService sharedJKService] FetchAllJobs:^(NSArray *resp, NSError *err) {
            [self hideLoading];
            if (err!=nil) {
                [self showError:err];
            }else{
                if ([resp isKindOfClass:[NSArray class]] && resp.count>0) {
                    self.searchResult = resp;
                    [self performSegueWithIdentifier:@"sid_searchjenkins2joblist" sender:self];

                }
            }
            
        }];
    }
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"sid_searchjenkins2joblist"]) {
        JenkinsJobListViewController *viewctrl = [segue destinationViewController];
        viewctrl.jobList = self.searchResult;
    }
    
}

@end


