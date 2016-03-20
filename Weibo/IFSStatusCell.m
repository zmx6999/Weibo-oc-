//
//  IFSTStatusCell.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusCell.h"

#import "IFSStatusTopView.h"
#import "IFSStatusRetweetView.h"
#import "IFSStatusBottomView.h"

#import "IFSStatus.h"

@interface IFSStatusCell ()

@property (nonatomic, weak) IFSStatusTopView *topView;
@property (nonatomic, weak) IFSStatusRetweetView *retweetView;
@property (nonatomic, weak) IFSStatusBottomView *bottomView;

@property (nonatomic, strong) MASConstraint *bottomViewTopConstraint;

@end

@implementation IFSStatusCell

+ (instancetype)statusCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"status";
    IFSStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    IFSStatusTopView *topView = [IFSStatusTopView topView];
    self.topView = topView;
    [self.contentView addSubview:self.topView];
    
    IFSStatusRetweetView *retweetView = [IFSStatusRetweetView retweetView];
    self.retweetView = retweetView;
    [self.contentView addSubview:self.retweetView];
    
    IFSStatusBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:@"IFSStatusBottomView" owner:nil options:nil] firstObject];
    self.bottomView = bottomView;
    [self.contentView addSubview:self.bottomView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
    }];
    
    [self.retweetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.contentView).offset(StatusMargin);
        make.right.equalTo(self.contentView).offset(-StatusMargin);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.bottomViewTopConstraint = make.top.equalTo(self.retweetView.mas_bottom).offset(StatusMargin);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.bottomView);
    }];
}

- (void)setStatus:(IFSStatus *)status {
    _status = status;
    
    self.topView.status = status;
    
    self.retweetView.hidden = (status.retweeted_status == nil);
    if (!self.retweetView.hidden) {
        self.retweetView.retweetStatus = status.retweeted_status;
    }
    
    [self.bottomViewTopConstraint uninstall];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.retweetView.hidden) {
            self.bottomViewTopConstraint = make.top.equalTo(self.topView.mas_bottom);
        } else {
            self.bottomViewTopConstraint = make.top.equalTo(self.retweetView.mas_bottom).offset(StatusMargin);
        }
    }];
}

@end
