
//
//  IFSStatusPictureView.m
//  Weibo
//
//  Created by zmx on 16/3/17.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSStatusPictureView.h"
#import "SDWebImageManager.h"
#import "IFSStatusPictureCell.h"
#import "SDPhotoBrowser/SDPhotoBrowser.h"

#define KCol 3
#define identifier @"picture"

@interface IFSStatusPictureView () <UICollectionViewDataSource, UICollectionViewDelegate, SDPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) MASConstraint *constraint;

@property (nonatomic, assign) CGSize size;

@end

@implementation IFSStatusPictureView

- (void)setPicUrls:(NSArray *)picUrls {
    _picUrls = picUrls;
    [self.collectionView reloadData];
    
    [self.constraint uninstall];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        self.constraint = make.size.mas_equalTo(self.size);
    }];
}

- (CGSize)size {
    if (self.picUrls.count < 1) {
        return CGSizeZero;
    }
    
    CGFloat maxWidth = ScreenW - StatusMargin * 2 - StatusMargin * 2;
    
    if (self.picUrls.count == 1) {
        CGSize imageSize = CGSizeMake(180, 120);
        NSURL *url = self.picUrls.firstObject;
        NSString *urlStr = url.absoluteString;
        UIImage *image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:urlStr];
        if (image != nil) {
            imageSize.width = maxWidth;
            imageSize.height = maxWidth / image.size.width * image.size.height;
        }
        self.layout.itemSize = imageSize;
        return self.layout.itemSize;
    }
    
    CGFloat imageW = (maxWidth - StatusPictureMargin * (KCol - 1)) / KCol;
    self.layout.itemSize = CGSizeMake(imageW, imageW);
    
    if (self.picUrls.count == 4) {
        CGFloat w = imageW * 2 + StatusPictureMargin;
        return CGSizeMake(w, w);
    }
    
    NSInteger row = (self.picUrls.count - 1) / KCol + 1;
    CGFloat h = imageW * row + StatusPictureMargin * (row - 1);
    return CGSizeMake(maxWidth, h);
}

- (void)awakeFromNib {
    [self.collectionView registerNib:[UINib nibWithNibName:@"IFSStatusPictureCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFSStatusPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSURL *url = self.picUrls[indexPath.item];
    cell.picUrl = url;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = collectionView;
    browser.imageCount = self.picUrls.count;
    browser.currentImageIndex = indexPath.item;
    browser.delegate = self;
    [browser show];
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSURL *url = self.picUrls[index];
    NSString *urlStr = url.absoluteString;
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
    return [NSURL URLWithString:urlStr];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    IFSStatusPictureCell *cell = (IFSStatusPictureCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    return cell.imageView.image;
}

@end