//
//  IFSEmotionTextView.h
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IFSEmotion;

@interface IFSEmotionTextView : UITextView

- (void)insertEmotion:(IFSEmotion *)emotion;

- (NSString *)fullText;

@end
