//
//  IFSAccountViewModel.h
//  Weibo
//
//  Created by zmx on 16/3/12.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFSAccount.h"

@interface IFSAccountViewModel : NSObject

+ (void)saveAccount:(IFSAccount *)account;
+ (IFSAccount *)sharedAccount;

+ (void)fetchAccessTokenWithCode:(NSString *)code responseHandler:(void (^)(IFSAccount *account))responseHandler;
+ (void)fetchUserInfoWithAccount:(IFSAccount *)account responseHandler:(void (^)(BOOL success))responseHandler;

@end
