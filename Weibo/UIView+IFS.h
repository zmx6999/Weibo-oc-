//
//  UIView+IFS.h
//  Weibo
//
//  Created by zmx on 16/3/14.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IFS)

- (UIViewController *)getViewController;

- (void)choosePhotoFromLocalLibraryWithDelegate:(id)delegate;
- (void)takePhotoWithDelegate:(id)delegate;

- (void)addPhotWithDelegate:(id)delegate;
- (void)clickAddPhotoActionSheetButtonAtIndex:(NSInteger)index;

@end
