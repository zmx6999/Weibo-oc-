//
//  IFSNewFeatureCell.m
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSNewFeatureCell.h"
#import "IFSTabBarController.h"
#import "IFSWelcomeViewController.h"

@implementation IFSNewFeatureCell

- (IBAction)begin:(id)sender {
    if (SharedUser) {
        self.window.rootViewController = [[IFSWelcomeViewController alloc] init];
    } else {
        self.window.rootViewController = [[IFSTabBarController alloc] init];
    }
}

- (void)startAnimation {
    self.startButton.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:0 animations:^{
        self.startButton.transform = CGAffineTransformIdentity;
        [self layoutIfNeeded];
    } completion:nil];
}

@end
