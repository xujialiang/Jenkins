//
//  JobDescViewController.m
//  JenkinsRobo
//
//  Created by jialiang.xu on 15/2/6.
//  Copyright (c) 2015年 DataYesRobo. All rights reserved.
//

#import "JobDescViewController.h"
#import "MBProgressHUD.h"
#import "ProjectHelper.h"
#import "AFNetworking.h"

@interface JobDescViewController ()


@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_buildingstatus;
@property (weak, nonatomic) IBOutlet UILabel *lbl_cause;

@property (weak, nonatomic) IBOutlet UILabel *lbl_duration;
@property (weak, nonatomic) IBOutlet UILabel *estimatedDuration;
@property (weak, nonatomic) IBOutlet UITextView *txt_changes;
@property (nonatomic,strong) NSDictionary *resultData;
- (IBAction)DoBuild:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDoBuild;

@end

@implementation JobDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

-(void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *detail = [ProjectHelper FetchProject:self.projectName];
    NSString *api = [[detail objectForKey:@"url"] stringByAppendingString:@"api/json"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    
    [manager GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        NSInteger jobnumber = [[[responseObject objectForKey:@"lastBuild"] objectForKey:@"number"] integerValue];
        NSString *jobapi = [[detail objectForKey:@"url"] stringByAppendingString:[NSString stringWithFormat:@"%ld/api/json",jobnumber]];
        [manager GET:jobapi parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
            self.resultData = responseObject;
            [self bindData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showError:error];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showError:error];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)bindData{
    self.lbl_name.text = [self.resultData objectForKey:@"fullDisplayName"];
    self.lbl_buildingstatus.text = [[self.resultData objectForKey:@"building"] boolValue]?@"正在构建":@"已构建";
    
    if ([[self.resultData objectForKey:@"building"] boolValue]) {
        self.btnDoBuild.enabled=NO;
    }else{
        self.btnDoBuild.enabled=YES;
    }
    
    NSDictionary *dic =  [self.resultData objectForKey:@"actions"][0];
    [[self.resultData objectForKey:@"actions"] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if([obj objectForKey:@"causes"]){
            NSString * causestr = [[dic objectForKey:@"causes"][0] objectForKey:@"shortDescription"];
            self.lbl_cause.text = causestr;
        }
    }];
    
    self.estimatedDuration.text = [NSString stringWithFormat:@"%.1f分钟",[[self.resultData objectForKey:@"estimatedDuration"] integerValue]/1000/60.0];
    
    
    if ([[self.resultData objectForKey:@"duration"] integerValue] == 0) {
        NSInteger timestamp = [[self.resultData objectForKey:@"timestamp"] integerValue];

        NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
        
        self.lbl_duration.text =[self compareCurrentTime:publishDate];
    }else{
        self.lbl_duration.text = [NSString stringWithFormat:@"%.1f分钟",[[self.resultData objectForKey:@"duration"] integerValue]/1000/60.0];
    }
    
    
    
    
    
    NSDictionary *changeDic =[self.resultData objectForKey:@"changeSet"];
    NSArray *changeArray = [changeDic objectForKey:@"items"];
    NSString *changeResult =@"";
    [changeArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj objectForKey:@"affectedPaths"]) {
            NSArray *affectedPaths = [obj objectForKey:@"affectedPaths"];
            [affectedPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [[changeResult stringByAppendingString:obj] stringByAppendingString:@"\r\n"];
            }];
        }
    }];
    if (changeArray.count==0) {
        self.txt_changes.text = @"没变化";
    }else{
        self.txt_changes.text = changeResult;
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)DoBuild:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    
    NSDictionary *detail = [ProjectHelper FetchProject:self.projectName];
    NSString *api = [[detail objectForKey:@"url"] stringByAppendingString:@"build?delay=0sec"];
    
    
    [manager GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self loadData];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showError:error];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

-(NSString *) compareCurrentTime:(NSDate*) compareDate

{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
@end
