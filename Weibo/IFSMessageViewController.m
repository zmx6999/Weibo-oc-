//
//  IFSMessageViewController.m
//  Weibo
//
//  Created by zmx on 16/3/11.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSMessageViewController.h"

@interface IFSMessageViewController ()

@end

@implementation IFSMessageViewController

- (void)loadView {
    [super loadView];
    
    [self.beforeLoginView setupWithTip:@"登录后，别人评论你的微博，发给你的消息，都会在这里收到通知" iconName:@"visitordiscover_image_message"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
