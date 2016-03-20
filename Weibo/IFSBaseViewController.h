//
//  IFSBaseViewController.h
//  Weibo
//
//  Created by zmx on 16/3/11.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFSBeforeLoginView.h"

@interface IFSBaseViewController : UITableViewController

@property (nonatomic, weak) IFSBeforeLoginView *beforeLoginView;

@end
