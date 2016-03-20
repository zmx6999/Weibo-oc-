//
//  IFSComposeViewModel.m
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSComposeViewModel.h"

@implementation IFSComposeViewModel

+ (void)sendStatus:(NSString *)status images:(NSArray *)images responseHandler:(void (^)(BOOL))responseHandler {
    NSDictionary *params = @{
                             @"access_token": SharedUser.access_token,
                             @"status": status
                             };
    if (images.count > 0) {
        [SharedNetworkManager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *image = images.firstObject;
            NSData *data = UIImageJPEGRepresentation(image, 0.1);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            responseHandler(YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            responseHandler(NO);
        }];
    } else {
        [SharedNetworkManager POST:@"2/statuses/update.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            responseHandler(YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            responseHandler(NO);
        }];
    }
}

@end
