//
//  IFSEmotionCell.m
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSEmotionCell.h"
#import "IFSEmotion.h"

@interface IFSEmotionCell ()

@property (weak, nonatomic) IBOutlet UIButton *emotionBtn;  //在xib预先设置占位图片，否则图片会被渲染成蓝色

@end

@implementation IFSEmotionCell

- (void)setEmotion:(IFSEmotion *)emotion {
    _emotion = emotion;
    
    [self.emotionBtn setTitle:emotion.emojiStr forState:UIControlStateNormal];
    [self.emotionBtn setImage:[UIImage imageWithContentsOfFile:emotion.imgPath] forState:UIControlStateNormal];
    if (emotion.isDelete) {
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    }
}

@end
