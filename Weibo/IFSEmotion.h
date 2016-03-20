//
//  IFSEmotion.h
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFSEmotion : NSObject

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *chs;
@property (nonatomic, copy) NSString *png;
@property (nonatomic, copy, readonly) NSString *imgPath;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy, readonly) NSString *emojiStr;
@property (nonatomic, assign) BOOL isEmpty;  //空表情标记
@property (nonatomic, assign) BOOL isDelete;  //删除键标记

+ (instancetype)emotionWithDict:(NSDictionary *)dict;

@end
