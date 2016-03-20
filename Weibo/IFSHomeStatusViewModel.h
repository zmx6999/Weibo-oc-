//
//  IFSHomeStatusViewModel.h
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFSHomeStatusViewModel : NSObject

+ (void)fetchStatusesWithResponseHandler:(void (^)(NSArray *statuses))responseHandler;
+ (void)fetchStatusesWithSinceId:(NSInteger)sinceId responseHandler:(void (^)(NSArray *statuses))responseHandler;
+ (void)fetchStatusesWithMaxId:(NSInteger)maxId responseHandler:(void (^)(NSArray *statuses))responseHandler;
+ (void)fetchStatusesWithSinceId:(NSInteger)sinceId maxId:(NSInteger)maxId responseHandler:(void (^)(NSArray *statuses))responseHandler;

@end
