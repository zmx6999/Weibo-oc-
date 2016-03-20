//
//  IFSStatus.h
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IFSUser;

@interface IFSStatus : NSObject

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, strong) IFSUser *user;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy, readonly) NSString *createdAt;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy, readonly) NSString *sourceStr;
@property (nonatomic, copy, readonly) NSString *sourceHref;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy, readonly) NSAttributedString *attributedText;
@property (nonatomic, strong) NSArray *pic_urls;
@property (nonatomic, strong, readonly) NSArray *picUrls;
@property (nonatomic, strong) IFSStatus *retweeted_status;

+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
