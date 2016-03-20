//
//  IFSBaseViewController.m
//  Weibo
//
//  Created by zmx on 16/3/11.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSBaseViewController.h"

@interface IFSBaseViewController ()

@end

@implementation IFSBaseViewController

- (void)loadView {
    if (SharedUser == nil) {
        IFSBeforeLoginView *beforeLoginView = [[[NSBundle mainBundle] loadNibNamed:@"IFSBeforeLoginView" owner:nil options:nil] firstObject];
        self.view = beforeLoginView;
        self.beforeLoginView = beforeLoginView;
    } else {
        [super loadView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
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
