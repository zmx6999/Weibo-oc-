//
//  IFSEmotionView.h
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IFSEmotion;

typedef void(^InsertEmotion)(IFSEmotion *emotion);

@interface IFSEmotionView : UIView

@property (nonatomic, copy) InsertEmotion insertEmotion;

@end
