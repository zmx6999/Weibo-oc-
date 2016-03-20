//
//  IFSWelcomeViewController.m
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSWelcomeViewController.h"
#import "IFSTabBarController.h"
#import "IFSAccount.h"

@interface IFSWelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation IFSWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageView.layer.cornerRadius = 45;
    self.imageView.layer.masksToBounds = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:SharedUser.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
    
    self.titleLabel.text = [SharedUser.name stringByAppendingString:@"  欢迎回来"];
    
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.98 initialSpringVelocity:9.8 options:0 animations:^{
        self.imageBottomConstraint.constant = ScreenH - 200;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.titleLabel.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.view.window.rootViewController = [[IFSTabBarController alloc] init];
        }];
    }];
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
