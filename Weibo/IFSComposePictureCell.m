//
//  IFSComposePictureCell.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSComposePictureCell.h"

@interface IFSComposePictureCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation IFSComposePictureCell

- (void)onTap:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(composePictureCellWillAddImage:)]) {
        [self.delegate composePictureCellWillAddImage:self.image];
    }
}

- (IBAction)remove:(id)sender {
    if ([self.delegate respondsToSelector:@selector(composePictureCellWillRemoveImage:)]) {
        [self.delegate composePictureCellWillRemoveImage:self.image];
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;
    if (image == nil) {
        self.imageView.image = [UIImage imageNamed:@"compose_pic_add"];
    } else {
        self.imageView.image = image;
    }
}

- (void)awakeFromNib {
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
}

@end
