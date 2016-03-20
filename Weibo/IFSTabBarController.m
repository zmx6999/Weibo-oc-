//
//  IFSTabBarController.m
//  Weibo
//
//  Created by zmx on 16/3/11.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSTabBarController.h"
#import "IFSTabBar.h"
#import "IFSHomeViewController.h"
#import "IFSMessageViewController.h"
#import "IFSDiscoverViewController.h"
#import "IFSProfileViewController.h"

@interface IFSTabBarController ()

@end

@implementation IFSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    IFSTabBar *tabBar = [[IFSTabBar alloc] initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKey:@"tabBar"];
    [self addViewControllers];
}

- (void)addViewControllers {
    [self addViewController:[[IFSHomeViewController alloc] init] title:@"首页" imageName:@"tabbar_home"];
    [self addViewController:[[IFSMessageViewController alloc] init] title:@"消息" imageName:@"tabbar_message_center"];
    [self addViewController:[[IFSDiscoverViewController alloc] init] title:@"发现" imageName:@"tabbar_discover"];
    [self addViewController:[[IFSProfileViewController alloc] init] title:@"我" imageName:@"tabbar_profile"];
}

- (void)addViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName {
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
    viewController.title = title;
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
