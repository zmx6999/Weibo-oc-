//
//  IFSStatusTopView.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusTopView.h"
#import "IFSStatusOriginTopView.h"
#import "IFSStatusPictureView.h"
#import "IFSStatus.h"

@interface IFSStatusTopView ()

@property (nonatomic, weak) IFSStatusOriginTopView *originTopView;
@property (nonatomic, weak) IFSStatusPictureView *originPictureView;

@property (nonatomic,strong) MASConstraint *bottomConstraint;

@end

@implementation IFSStatusTopView

+ (instancetype)topView {
    IFSStatusTopView *topView = [[self alloc] init];
    [topView setupUI];
    return topView;
}

- (void)setupUI {
    IFSStatusOriginTopView *originTopView = [[[NSBundle mainBundle] loadNibNamed:@"IFSStatusOriginTopView" owner:nil options:nil] firstObject];
    self.originTopView = originTopView;
    [self addSubview:self.originTopView];
    
    IFSStatusPictureView *originPictureView = [[[NSBundle mainBundle] loadNibNamed:@"IFSStatusPictureView" owner:nil options:nil] firstObject];
    self.originPictureView = originPictureView;
    [self addSubview:self.originPictureView];
    
    [self.originTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [self.originPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originTopView.mas_bottom);
        make.left.equalTo(self).offset(StatusMargin);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        self.bottomConstraint = make.bottom.equalTo(self.originPictureView).offset(StatusMargin);
    }];
}

- (void)setStatus:(IFSStatus *)status {
    _status = status;
    
    self.originTopView.status = status;
    
    self.originPictureView.hidden = (status.picUrls.count < 1);
    self.originPictureView.picUrls = status.picUrls;
    
    [self.bottomConstraint uninstall];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.originPictureView.hidden) {
            self.bottomConstraint = make.bottom.equalTo(self.originTopView);
        } else {
            self.bottomConstraint = make.bottom.equalTo(self.originPictureView).offset(StatusMargin);
        }
    }];
    
}

@end
