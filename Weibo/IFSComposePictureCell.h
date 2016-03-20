//
//  IFSComposePictureCell.h
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IFSComposePictureCell;

@protocol IFSComposePictureCellDelegate <NSObject>

- (void)composePictureCellWillAddImage:(UIImage *)image;
- (void)composePictureCellWillRemoveImage:(UIImage *)image;

@end

@interface IFSComposePictureCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id<IFSComposePictureCellDelegate> delegate;

@end
