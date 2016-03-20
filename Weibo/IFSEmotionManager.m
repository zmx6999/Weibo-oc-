//
//  IFSEmotionManager.m
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSEmotionManager.h"
#import "IFSEmotionPackage.h"
#import "IFSEmotion.h"

static IFSEmotionManager *_instance;

@implementation IFSEmotionManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Emoticons.bundle/emoticons.plist" ofType:nil]];
        [_instance setValuesForKeysWithDictionary:dict];
    });
    return _instance;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"packages"]) {
        NSArray *packages = (NSArray *)value;
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in packages) {
            IFSEmotionPackage *package = [IFSEmotionPackage emotionPackageWithId:[dict objectForKey:@"id"]];
            [arrM addObject:package];
        }
        self.packages = arrM;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (IFSEmotion *)getEmotionWithName:(NSString *)name {
    for (IFSEmotionPackage *package in self.packages) {
        for (IFSEmotion *emotion in package.emoticons) {
            if ([emotion.chs isEqualToString:name]) {
                return emotion;
            }
        }
    }
    return nil;
}

@end
