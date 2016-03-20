//
//  IFSComposePictureView.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSComposePictureContentView.h"
#import "IFSComposePictureCell.h"

#define KColCount 4
#define identifier @"compose_picture"

@interface IFSComposePictureContentView () <UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IFSComposePictureCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@end

@implementation IFSComposePictureContentView

- (void)awakeFromNib {
    CGFloat imageW = (ScreenW - StatusPictureMargin * (KColCount + 1)) / KColCount;
    self.layout.itemSize = CGSizeMake(imageW, imageW);
    self.layout.sectionInset = UIEdgeInsetsMake(StatusPictureMargin, StatusPictureMargin, 0, StatusPictureMargin);
    [self.collectionView registerNib:[UINib nibWithNibName:@"IFSComposePictureCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger n = self.images.count;
    return n < 9 ?n + 1 : n;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFSComposePictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSInteger imageCount = self.images.count;
    cell.delegate = self;
    cell.image = (indexPath.row == imageCount ?nil : [self.images objectAtIndex:indexPath.row]);
    cell.closeBtn.hidden = (indexPath.row == imageCount);
    
    return cell;
}

- (void)addImage {
    if (self.images.count >= 9) {
        return;
    }
    
    [self composePictureCellWillAddImage:nil];
}

- (void)composePictureCellWillAddImage:(UIImage *)image {
    if (image) {
        return;
    }
    
    [self addPhotWithDelegate:self];
}

- (void)composePictureCellWillRemoveImage:(UIImage *)image {
    [self.images removeObject:image];
    [self.collectionView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self clickAddPhotoActionSheetButtonAtIndex:buttonIndex];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.images addObject:image];
    [self.collectionView reloadData];
}

@end