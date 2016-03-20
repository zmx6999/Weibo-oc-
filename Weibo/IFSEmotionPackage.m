//
//  IFSEmotionPackage.m
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSEmotionPackage.h"
#import "IFSEmotion.h"

@implementation IFSEmotionPackage

+ (instancetype)emotionPackageWithId:(NSString *)idstr {
    IFSEmotionPackage *package = [[self alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Emoticons.bundle/%@/Info.plist", idstr] ofType:nil]];
    NSLog(@"%@", dict);
    [package setValuesForKeysWithDictionary:dict];
    return package;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.idstr = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"emoticons"]) {
        NSArray *emoticons = (NSArray *)value;
        self.emoticons = [self insertEmotionsWithArray:emoticons];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (NSArray *)insertEmotionsWithArray:(NSArray *)emoticons {
    NSMutableArray *arrM = [NSMutableArray array];
    
    int i = 0;
    for (; i < emoticons.count; i++) {
        NSDictionary *dict = emoticons[i];
        IFSEmotion *emotion = [IFSEmotion emotionWithDict:dict];
        emotion.idstr = self.idstr;
        [arrM addObject:emotion];
        
        if ((i + 1) % 20 == 0) {
            IFSEmotion *deleteEmo = [[IFSEmotion alloc] init];
            deleteEmo.isDelete = YES;
            [arrM addObject:deleteEmo];
        }
    }
    
    int a = i % 20;
    if (a > 0) {
        for (int j = a; j < 20; j++) {
            IFSEmotion *emptyEmo = [[IFSEmotion alloc] init];
            emptyEmo.isEmpty = YES;
            [arrM addObject:emptyEmo];
        }
        
        IFSEmotion *deleteEmo = [[IFSEmotion alloc] init];
        deleteEmo.isDelete = YES;
        [arrM addObject:deleteEmo];
    }
    
    return arrM;
}

@end
