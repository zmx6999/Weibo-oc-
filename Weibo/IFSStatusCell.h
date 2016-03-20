//
//  IFSTStatusCell.h
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IFSStatus;

@interface IFSStatusCell : UITableViewCell

@property (nonatomic, strong) IFSStatus *status;

+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@end
