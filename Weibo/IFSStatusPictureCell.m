//
//  IFSStatusPictureCell.m
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusPictureCell.h"

@implementation IFSStatusPictureCell

- (void)setPicUrl:(NSURL *)picUrl {
    _picUrl = picUrl;
    [self.imageView sd_setImageWithURL:picUrl];
}

@end