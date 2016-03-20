//
//  IFSAccount.h
//  Weibo
//
//  Created by zmx on 16/3/12.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFSAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) NSTimeInterval expires_in;
@property (nonatomic, strong) NSDate *expiresTime;
@property (nonatomic, copy) NSString *remind_in;
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_large;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
