//
//  IFSTabBar.m
//  Weibo
//
//  Created by zmx on 16/3/11.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSTabBar.h"
#import "IFSComposeViewController.h"

#define kCount 5

@implementation IFSTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self addComposeBtn];
    return self;
}

- (void)addComposeBtn {
    UIButton *composeBtn = [[UIButton alloc] init];
    [self addSubview:composeBtn];
    [composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [composeBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [composeBtn addTarget:self action:@selector(compose:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int i = 0;
    CGFloat w = ScreenW / kCount;
    CGFloat h = self.frame.size.height;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGFloat x = w * (i < 2? i : (i + 1));
            CGFloat y = 0;
            subView.frame = CGRectMake(x, y, w, h);
            i++;
        } else if ([subView isKindOfClass:[UIButton class]]) {
            subView.frame = CGRectMake(w * 2, 0, w, h);
        }
    }
}

- (void)compose:(id)sender {
    IFSComposeViewController *cvc = [[IFSComposeViewController alloc] init];
    [[self getViewController] presentViewController:[[UINavigationController alloc] initWithRootViewController:cvc] animated:YES completion:nil];
}

@end
