//
//  IFSStatusTopView.m
//  Weibo
//
//  Created by zmx on 16/3/12.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusOriginTopView.h"
#import "IFSUser.h"
#import "IFSStatus.h"
#import "IFSStatusLinkViewController.h"

@interface IFSStatusOriginTopView () <FFLabelDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mbrankView;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet FFLabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedTypeView;

@end
	
@implementation IFSStatusOriginTopView

- (IBAction)onTap:(id)sender {
    IFSStatusLinkViewController *link = [[IFSStatusLinkViewController alloc] init];
    link.urlStr = self.status.sourceHref;
    [[self getViewController].navigationController pushViewController:link animated:YES];
}

- (void)setStatus:(IFSStatus *)status {
    _status = status;
    
    [self.profileImageView sd_setImageWithURL:status.user.profileImageUrl];
    self.nameLabel.text = status.user.name;
    self.mbrankView.image = status.user.mbrankImage;
    self.createdAtLabel.text = status.createdAt;
    self.sourceLabel.text = status.sourceStr;
    
    self.textLabel.attributedText = status.attributedText;
    self.textLabel.labelDelegate = self;
    
    self.verifiedTypeView.image = status.user.verifiedTypeImage;
}

- (void)labelDidSelectedLinkText:(FFLabel *)label text:(NSString *)text {
    if ([text hasPrefix:@"http"]) {
        IFSStatusLinkViewController *link = [[IFSStatusLinkViewController alloc] init];
        link.urlStr = text;
        [[self getViewController].navigationController pushViewController:link animated:YES];
    }
}

@end
