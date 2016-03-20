
//
//  IFSEmotionView.m
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSEmotionView.h"
#import "IFSEmotionManager.h"
#import "IFSEmotionPackage.h"
#import "IFSEmotionCell.h"

#define identifier @"emotion"
#define col 7
#define row 3

@interface IFSEmotionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) IFSEmotionManager *manager;

@end

@implementation IFSEmotionView

- (IBAction)chooseType:(UIBarButtonItem *)sender {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:sender.tag] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (IFSEmotionManager *)manager {
    if (_manager == nil) {
        _manager = [IFSEmotionManager sharedManager];
    }
    return _manager;
}

- (void)awakeFromNib {
    [self.collectionView registerNib:[UINib nibWithNibName:@"IFSEmotionCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    CGFloat itemW = ScreenW / col;
    self.layout.itemSize =CGSizeMake(itemW, itemW);
    CGFloat margin = (226 - 44 - itemW * row) / (row + 1);
    self.layout.sectionInset = UIEdgeInsetsMake(margin, 0, margin, 0);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.manager.packages.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    IFSEmotionPackage *package = self.manager.packages[section];
    return package.emoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFSEmotionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    IFSEmotionPackage *package = self.manager.packages[indexPath.section];
    IFSEmotion *emotion = package.emoticons[indexPath.item];
    cell.emotion = emotion;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    IFSEmotionPackage *package = self.manager.packages[indexPath.section];
    IFSEmotion *emotion = package.emoticons[indexPath.item];
    if (self.insertEmotion) {
        self.insertEmotion(emotion);
    }
}

@end