//
//  IFSStatusPictureCell.h
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFSStatusPictureCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSURL *picUrl;

@end
