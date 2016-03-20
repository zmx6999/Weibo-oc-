//
//  IFSStatusRetweetView.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusRetweetView.h"
#import "IFSStatusRetweetTopView.h"
#import "IFSStatusPictureView.h"
#import "IFSStatus.h"

@interface IFSStatusRetweetView ()

@property (nonatomic, weak) IFSStatusRetweetTopView *retweetTopView;
@property (nonatomic, weak) IFSStatusPictureView *retweetPictureView;

@property (nonatomic, strong) MASConstraint *bottomConstraint;

@end

@implementation IFSStatusRetweetView

+ (instancetype)retweetView {
    IFSStatusRetweetView *retweetView = [[IFSStatusRetweetView alloc] init];
    [retweetView setupUI];
    return retweetView;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    IFSStatusRetweetTopView *retweetTopView = [[[NSBundle mainBundle] loadNibNamed:@"IFSStatusRetweetTopView" owner:nil options:nil] firstObject];
    self.retweetTopView = retweetTopView;
    [self addSubview:self.retweetTopView];
    
    IFSStatusPictureView *retweetPictureView = [[[NSBundle mainBundle] loadNibNamed:@"IFSStatusPictureView" owner:nil options:nil] firstObject];
    self.retweetPictureView = retweetPictureView;
    [self addSubview:self.retweetPictureView];
    
    [self.retweetTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [self.retweetPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.retweetTopView.mas_bottom);
        make.left.equalTo(self).offset(StatusMargin);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        self.bottomConstraint = make.bottom.equalTo(self.retweetPictureView).offset(StatusMargin);
    }];
}

- (void)setRetweetStatus:(IFSStatus *)retweetStatus {
    _retweetStatus = retweetStatus;
    
    self.retweetTopView.retweetStatus = retweetStatus;
    
    self.retweetPictureView.hidden = (retweetStatus.picUrls.count < 1);
    self.retweetPictureView.picUrls = retweetStatus.picUrls;
    
    [self.bottomConstraint uninstall];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.retweetPictureView.hidden) {
            self.bottomConstraint = make.bottom.equalTo(self.retweetTopView);
        } else {
            self.bottomConstraint = make.bottom.equalTo(self.retweetPictureView).offset(StatusMargin);
        }
    }];
}

@end
