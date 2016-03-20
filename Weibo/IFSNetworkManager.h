//
//  IFSNetworkManager.h
//  Weibo
//
//  Created by zmx on 16/3/12.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface IFSNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedNetworkManager;

@end
