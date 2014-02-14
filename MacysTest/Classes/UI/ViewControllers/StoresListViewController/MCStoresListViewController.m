//
//  MCStoresListViewController.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/14/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCStoresListViewController.h"
#import "MCStoreCell.h"
#import "MCProduct.h"

@interface MCStoresListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MCStoresListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.product.stores = @[@"1", @"2", @"3"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self product] stores] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"MCStoreCell";
    MCStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        NSString *nibName = NSStringFromClass([MCStoreCell class]);
        cell = (MCStoreCell *)[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil][0];
    }
    
    NSString *storeName = [[self product] stores][[indexPath row]];
    [cell setStoreName:storeName];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
