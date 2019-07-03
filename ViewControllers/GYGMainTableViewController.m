//
//  GYGMainTableViewController.m
//  David
//
//  Created by David Liu on 7/2/19.
//  Copyright © 2019 GetYourGuide. All rights reserved.
//

#import "GYGMainTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "GYGHttpClient.h"
#import "GYGReviewTableViewCell.h"
#import "NSArray+Utility.h"

#define CELL_IDENTIFER @"defaultCell"

@interface GYGMainTableViewController ()
@property (nonatomic, strong) GYGHttpClient *httpClient;
@property (nonatomic, strong) NSMutableArray *reviews;
@end

@implementation GYGMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:GYGReviewTableViewCell.class forCellReuseIdentifier:CELL_IDENTIFER];
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *rnh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       [weakSelf _startLoading];
    }];
    rnh.lastUpdatedTimeLabel.hidden = YES;
    rnh.stateLabel.hidden = YES;
    rnh.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = rnh;
    
    MJRefreshAutoNormalFooter *ranf = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf _loadNextPage];
    }];
    ranf.refreshingTitleHidden = YES;
    ranf.stateLabel.hidden = YES;
    self.tableView.mj_footer = ranf;
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviews.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GYGReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFER forIndexPath:indexPath];
    GYGReviewModel *review = self.reviews[indexPath.row];
    cell.model = review;
    return cell;
}

#pragma mark - Private methods
- (void)_startLoading
{
    [[self.httpClient fetchReviews] continueWithBlock:^id _Nullable(BFTask * _Nonnull t) {
        self.reviews = [[NSMutableArray alloc] initWithArray:t.result];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        return nil;
    }];
}

- (void)_loadNextPage
{
    [[self.httpClient fetchNextReviews] continueWithBlock:^id _Nullable(BFTask * _Nonnull t) {
        NSArray *newReviews = t.result;
        if (!newReviews.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else {
            NSUInteger startIndex = self.reviews.count;
            NSArray *newIps = [newReviews arrayByManipulationBlock:^id _Nonnull(id  _Nonnull obj, NSUInteger ind) {
                return [NSIndexPath indexPathForRow:startIndex + ind inSection:0];
            }];
            [self.reviews addObjectsFromArray:newReviews];
            [self.tableView insertRowsAtIndexPaths:newIps withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView.mj_footer endRefreshing];
        }
        return nil;
    }];
}

#pragma mark - Lazy Instantiation
- (GYGHttpClient *)httpClient
{
    if (!_httpClient) {
        _httpClient = [[GYGHttpClient alloc] init];
    }
    return _httpClient;
}

@end
