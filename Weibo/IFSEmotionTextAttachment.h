//
//  IFSEmotionTextAttachment.h
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IFSEmotion;

@interface IFSEmotionTextAttachment : NSTextAttachment

@property (nonatomic, copy) NSString *chs;

- (NSAttributedString *)attributedStringWithEmotion:(IFSEmotion *)emotion font:(UIFont *)font;

@end
