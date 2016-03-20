//
//  IFSEmotionPackage.h
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFSEmotionPackage : NSObject

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSArray *emoticons;

+ (instancetype)emotionPackageWithId:(NSString *)idstr;

@end
