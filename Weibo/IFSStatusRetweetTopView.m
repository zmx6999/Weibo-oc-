//
//  IFSStatusRetweetTopView.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusRetweetTopView.h"
#import "IFSUser.h"
#import "IFSStatus.h"
#import "IFSStatusLinkViewController.h"

@interface IFSStatusRetweetTopView () <FFLabelDelegate>

@property (weak, nonatomic) IBOutlet FFLabel *textLabel;

@end

@implementation IFSStatusRetweetTopView

- (void)setRetweetStatus:(IFSStatus *)retweetStatus {
    _retweetStatus = retweetStatus;
    
    NSMutableAttributedString *aStrM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"@%@  ", retweetStatus.user.name]];
    [aStrM appendAttributedString:retweetStatus.attributedText];
    self.textLabel.attributedText = aStrM;
    self.textLabel.labelDelegate = self;
}

- (void)labelDidSelectedLinkText:(FFLabel *)label text:(NSString *)text {
    if ([text hasPrefix:@"http"]) {
        IFSStatusLinkViewController *link = [[IFSStatusLinkViewController alloc] init];
        link.urlStr = text;
        [[self getViewController].navigationController pushViewController:link animated:YES];
    }
}

@end
