//
//  IFSEmotion.m
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSEmotion.h"
#import "Weibo-Swift.h"

@implementation IFSEmotion

+ (instancetype)emotionWithDict:(NSDictionary *)dict {
    IFSEmotion *emotion = [[self alloc] init];
    [emotion setValuesForKeysWithDictionary:dict];
    return emotion;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)imgPath {
    return [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Emoticons.bundle/%@/%@", self.idstr, self.png]];
}

- (NSString *)emojiStr {
    return [IFSEmojiTool getEmojiStr:self.code];
}

@end
