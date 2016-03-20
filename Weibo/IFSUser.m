//
//  User.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSUser.h"

@implementation IFSUser

- (NSURL *)profileImageUrl {
    return [NSURL URLWithString:self.profile_image_url];
}

- (UIImage *)mbrankImage {
    if (self.mbrank > 0 && self.mbrank < 7) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%ld", self.mbrank]];
    }
    return nil;
}

- (UIImage *)verifiedTypeImage {
    switch (self.verified_type) {
        case 0: {
            return [UIImage imageNamed:@"avatar_vip"];
        }
            
        case 2:
        case 3:
        case 5: {
            return [UIImage imageNamed:@"avatar_enterprise_vip"];
        }
            
        case 220: {
            return [UIImage imageNamed:@"avatar_grassroot"];
        }
            
        default:
            return nil;
    }
}

+ (instancetype)userWithDict:(NSDictionary *)dict {
    IFSUser *user = [[self alloc] init];
    [user setValuesForKeysWithDictionary:dict];
    return user;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
