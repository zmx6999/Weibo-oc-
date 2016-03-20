//
//  IFSHomeViewController.m
//  Weibo
//
//  Created by zmx on 16/3/13.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IFSHomeViewController.h"
#import "IFSHomeStatusViewModel.h"
#import "IFSStatusCell.h"
#import "IFSStatus.h"
#import "IFSRefreshView.h"

@interface IFSHomeViewController () <IFSRefreshViewDelegate>

@property (nonatomic, weak) IFSRefreshView *header;
@property (nonatomic, weak) IFSRefreshView *footer;

@property (nonatomic, strong) NSArray *statuses;

@end

@implementation IFSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!SharedUser) {
        [self.beforeLoginView setupWithTip:nil iconName:nil];
        return;
    }
    
    [self setupTableView];
    [self setupRefreshView];
}

- (void)setupTableView {
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupRefreshView {
    IFSRefreshView *header = [IFSRefreshView refreshViewWithType:IFSHeader];
    self.header = header;
    self.header.scrollView = self.tableView;
    self.header.delegate = self;
    [self.header beginRefreshing];
    
    IFSRefreshView *footer = [IFSRefreshView refreshViewWithType:IFSFooter];
    self.footer = footer;
    self.footer.scrollView = self.tableView;
    self.footer.delegate = self;
}

- (void)loadData {
    [IFSHomeStatusViewModel fetchStatusesWithResponseHandler:^(NSArray *statuses) {
        [self.header endRefreshing];
        
        if (statuses == nil) {
            return;
        }
        
        self.statuses = statuses;
        [self.tableView reloadData];
    }];
}

- (void)loadNewData {
    if (self.statuses.count < 1) {
        return;
    }
    
    IFSStatus *status = self.statuses.firstObject;
    NSInteger sinceId = status.idstr.integerValue;
    
    [IFSHomeStatusViewModel fetchStatusesWithSinceId:sinceId responseHandler:^(NSArray *statuses) {
        [self.header endRefreshing];
        
        if (statuses == nil) {
            return;
        }
        
        NSMutableArray *arrM = [NSMutableArray array];
        [arrM addObjectsFromArray:statuses];
        [arrM addObjectsFromArray:self.statuses];
        self.statuses = arrM;
        [self.tableView reloadData];
    }];
}

- (void)loadMoreData {
    if (self.statuses.count < 1) {
        return;
    }
    
    IFSStatus *status = self.statuses.lastObject;
    NSInteger maxId = status.idstr.integerValue - 1;
    
    [IFSHomeStatusViewModel fetchStatusesWithMaxId:maxId responseHandler:^(NSArray *statuses) {
        [self.footer endRefreshing];
        
        if (statuses == nil) {
            return;
        }
        
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.statuses];
        [arrM addObjectsFromArray:statuses];
        self.statuses = arrM;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFSStatusCell *cell = [IFSStatusCell statusCellWithTableView:tableView];
    cell.status = [self.statuses objectAtIndex:indexPath.row];
    return cell;
}

- (void)refreshViewDidBeginRefreshing:(IFSRefreshView *)refreshView {
    if (refreshView.type == IFSHeader) {
        if (self.statuses.count > 0) {
            [self loadNewData];
        } else {
            [self loadData];
        }
    } else if (refreshView.type == IFSFooter) {
        [self loadMoreData];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
