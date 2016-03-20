//
//  IFSAccountViewModel.m
//  Weibo
//
//  Created by zmx on 16/3/12.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSAccountViewModel.h"
#import "IFSAccount.h"

#define path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.plist"]

@implementation IFSAccountViewModel

+ (void)saveAccount:(IFSAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:path];
}

+ (IFSAccount *)sharedAccount {
    IFSAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if ([[NSDate date] compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    }
    return nil;
}

+ (void)fetchAccessTokenWithCode:(NSString *)code responseHandler:(void (^)(IFSAccount *))responseHandler {
    NSDictionary *params = @{
                             @"client_id": AppKey,
                             @"client_secret": AppSecret,
                             @"grant_type": @"authorization_code",
                             @"code": code,
                             @"redirect_uri": RedirectUri
                             };
    [SharedNetworkManager POST:@"oauth2/access_token" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        IFSAccount *account = [IFSAccount accountWithDict:responseObject];
        responseHandler(account);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(nil);
        NSLog(@"%@", error);
    }];
}

+ (void)fetchUserInfoWithAccount:(IFSAccount *)account responseHandler:(void (^)(BOOL))responseHandler {
    NSDictionary *params = @{
                             @"access_token": account.access_token,
                             @"uid": account.uid
                             };
    [SharedNetworkManager GET:@"2/users/show.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [account setValuesForKeysWithDictionary:responseObject];
        [self saveAccount:account];
        responseHandler(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(NO);
        NSLog(@"%@", error);
    }];
}

@end
