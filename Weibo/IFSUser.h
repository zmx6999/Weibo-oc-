//
//  User.h
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFSUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, strong, readonly) NSURL *profileImageUrl;
@property (nonatomic, assign) NSInteger mbrank;
@property (nonatomic, strong, readonly) UIImage *mbrankImage;
@property (nonatomic, assign) NSInteger verified_type;
@property (nonatomic, strong, readonly) UIImage *verifiedTypeImage;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
