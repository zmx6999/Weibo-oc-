//
//  IFSNewFeatureCell.h
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFSNewFeatureCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (void)startAnimation;

@end