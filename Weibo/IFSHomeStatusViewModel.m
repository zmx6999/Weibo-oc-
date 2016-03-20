//
//  IFSHomeStatusViewModel.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSHomeStatusViewModel.h"
#import "IFSStatus.h"

@implementation IFSHomeStatusViewModel

+ (void)fetchStatusesWithResponseHandler:(void (^)(NSArray *))responseHandler {
    [self fetchStatusesWithSinceId:0 maxId:0 responseHandler:responseHandler];
}

+ (void)fetchStatusesWithSinceId:(NSInteger)sinceId responseHandler:(void (^)(NSArray *))responseHandler {
    [self fetchStatusesWithSinceId:sinceId maxId:0 responseHandler:responseHandler];
}

+ (void)fetchStatusesWithMaxId:(NSInteger)maxId responseHandler:(void (^)(NSArray *))responseHandler {
    [self fetchStatusesWithSinceId:0 maxId:maxId responseHandler:responseHandler];
}

+ (void)fetchStatusesWithSinceId:(NSInteger)sinceId maxId:(NSInteger)maxId responseHandler:(void (^)(NSArray *))responseHandler {
    NSDictionary *params = @{
                             @"access_token": SharedUser.access_token,
                             @"count": @(10),
                             @"since_id": @(sinceId),
                             @"max_id": @(maxId)
                             };
    [SharedNetworkManager GET:@"2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *statuses = [responseObject objectForKey:@"statuses"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in statuses) {
            IFSStatus *status = [IFSStatus statusWithDict:dict];
            [arrM addObject:status];
        }
        
        responseHandler(arrM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(nil);
        NSLog(@"%@", error);
    }];
}

@end
