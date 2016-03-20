//
//  IFSEmotionTextView.m
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSEmotionTextView.h"
#import "IFSEmotion.h"
#import "IFSEmotionTextAttachment.h"

@implementation IFSEmotionTextView

- (void)insertEmotion:(IFSEmotion *)emotion {
    if (emotion.isEmpty) {
        return;
    }
    
    if (emotion.isDelete) {
        [self deleteBackward];
        return;
    }
    
    if (emotion.code) {
        [self replaceRange:self.selectedTextRange withText:emotion.emojiStr];
        return;
    }
    
    UIFont *font = self.font;
    NSRange range = self.selectedRange;
    NSMutableAttributedString *aStrM = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    IFSEmotionTextAttachment *attachment = [[IFSEmotionTextAttachment alloc] init];
    [aStrM replaceCharactersInRange:range withAttributedString:[attachment attributedStringWithEmotion:emotion font:font]];
    [aStrM addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, aStrM.length)];
    self.attributedText = aStrM;
    self.selectedRange = NSMakeRange(range.location + 1, 0);
}

- (NSString *)fullText {
    NSMutableString *strM = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        IFSEmotionTextAttachment *attachment = attrs[@"NSAttachment"];
        if (attachment) {
            [strM appendString:attachment.chs];
        } else {
            [strM appendString:[self.text substringWithRange:range]];
        }
    }];
    return strM;
}

@end