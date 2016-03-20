//
//  IFSComposePictureView.m
//  Weibo
//
//  Created by zmx on 16/3/15.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSComposePictureView.h"
#import "IFSComposePictureContentView.h"

@interface IFSComposePictureView ()

@property (nonatomic, weak) IFSComposePictureContentView *contentView;

@end

@implementation IFSComposePictureView

- (void)awakeFromNib {
    IFSComposePictureContentView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"IFSComposePictureContentView" owner:nil options:nil] firstObject];
    self.contentView = contentView;
    [self addSubview:self.contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (NSArray *)images {
    if (_images == nil) {
        _images = self.contentView.images;
    }
    return _images;
}

- (void)addImage {
    [self.contentView addImage];
}

@end
