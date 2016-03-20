//
//  UIView+IFS.m
//  Weibo
//
//  Created by zmx on 16/3/14.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "UIView+IFS.h"

@implementation UIView (IFS) 

- (UIViewController *)getViewController {
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        nextResponder = nextResponder.nextResponder;
    }
    return nil;
}

- (void)choosePhotoFromLocalLibraryWithDelegate:(id)delegate {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = delegate;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [[self getViewController] presentViewController:picker animated:YES completion:nil];
}

- (void)takePhotoWithDelegate:(id)delegate {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = delegate;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [[self getViewController] presentViewController:picker animated:YES completion:nil];
}

- (void)addPhotWithDelegate:(id)delegate {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:delegate cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选择", nil];
    [actionSheet showInView:[self getViewController].view];
}

- (void)clickAddPhotoActionSheetButtonAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            [self choosePhotoFromLocalLibraryWithDelegate:self];
            break;
        }
            
        case 1: {
            [self takePhotoWithDelegate:self];
        }
            
        default:
            break;
    }
}

@end
