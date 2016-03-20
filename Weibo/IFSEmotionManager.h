//
//  IFSEmotionManager.h
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IFSEmotion;

@interface IFSEmotionManager : NSObject

@property (nonatomic, strong) NSArray *packages;

+ (instancetype)sharedManager;

- (IFSEmotion *)getEmotionWithName:(NSString *)name;

@end
