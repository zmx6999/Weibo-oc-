//
//  IFSBeforeLoginView.m
//  Weibo
//
//  Created by zmx on 16/3/11.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSBeforeLoginView.h"
#import "IFSLoginViewController.h"

@interface IFSBeforeLoginView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *homeIconView;
@property (weak, nonatomic) IBOutlet UIImageView *maskView;

@end

@implementation IFSBeforeLoginView

- (IBAction)login:(id)sender {
    [[self getViewController] presentViewController:[[UINavigationController alloc] initWithRootViewController:[[IFSLoginViewController alloc] init]] animated:YES completion:nil];
}

- (void)setupWithTip:(NSString *)tip iconName:(NSString *)iconName {
    if (tip != nil && iconName != nil) {
        self.iconView.image = [UIImage imageNamed:iconName];
        self.tipLabel.text = tip;
        self.homeIconView.hidden = YES;
        self.maskView.hidden = YES;
    } else {
        self.homeIconView.hidden = NO;
        self.maskView.hidden = NO;
        [self startIconRotation];
    }
}

- (void)startIconRotation {
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI * 2);
    anim.duration = 20;
    anim.repeatCount = MAXFLOAT;
    anim.removedOnCompletion = NO;
    [self.iconView.layer addAnimation:anim forKey:nil];
}

@end
