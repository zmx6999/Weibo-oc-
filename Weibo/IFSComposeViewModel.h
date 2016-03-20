//
//  IFSComposeViewModel.h
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFSComposeViewModel : NSObject

+ (void)sendStatus:(NSString *)status images:(NSArray *)images responseHandler:(void (^)(BOOL success))responseHandler;

@end
