//
//  IFSAccount.m
//  Weibo
//
//  Created by zmx on 16/3/12.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSAccount.h"

@implementation IFSAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    IFSAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dict];
    return account;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"expires_in"]) {
        self.expiresTime = [NSDate dateWithTimeIntervalSinceNow:_expires_in];
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeDouble:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.avatar_large forKey:@"avatar_large"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
    self.expires_in = [aDecoder decodeDoubleForKey:@"expires_in"];
    self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
    self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
    self.uid = [aDecoder decodeObjectForKey:@"uid"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
    
    return self;
}

@end
