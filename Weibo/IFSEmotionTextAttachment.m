//
//  IFSEmotionTextAttachment.m
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSEmotionTextAttachment.h"
#import "IFSEmotion.h"

@implementation IFSEmotionTextAttachment

- (NSAttributedString *)attributedStringWithEmotion:(IFSEmotion *)emotion font:(UIFont *)font {
    self.chs = emotion.chs;
    self.image = [UIImage imageWithContentsOfFile:emotion.imgPath];
    self.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
    NSMutableAttributedString *aStrM = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:self]];
    return aStrM;
}

@end