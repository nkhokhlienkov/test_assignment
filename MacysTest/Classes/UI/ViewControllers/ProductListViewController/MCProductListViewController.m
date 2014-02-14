//
//  MCProductListViewController.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCProductListViewController.h"
#import "MCProductShortcutCell.h"
#import "MCProductDetailsViewController.h"
#import "MCProduct.h"
#import "MCDataProvider.h"

@interface MCProductListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation MCProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setRightBarButtonItemWithTitle:@"Edit"];
    
    [self reloadItems];
}

#pragma mark - Private methods

- (void)reloadItems {
    
    [self setProducts:[NSMutableArray arrayWithArray:[[MCDataProvider sharedInstance] getAllProducts]]];
    [[self tableView] reloadData];
}

#pragma mark - Actions

- (void)setRightBarButtonItemWithTitle:(NSString *)title {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStyleBordered 
                                                            target:self 
                                                            action:@selector(editButtonWasClicked)];
    
    [[self navigationItem] setRightBarButtonItem:item];
}


- (void)editButtonWasClicked {
    
    if ([[self tableView] isEditing]) {
        [self setRightBarButtonItemWithTitle:@"Edit"];
    } else {
        [self setRightBarButtonItemWithTitle:@"Done"];
    }
    
    [[self tableView] setEditing:![[self tableView] isEditing]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MCProductShortcutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MCProductShortcutCell class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MCProductShortcutCell class]) owner:self options:nil][0];
    }
    MCProduct *product = self.products[indexPath.row];
    [[cell imageViewThumbnail] setImage:product.image];
    [[cell labelTitle] setText:product.name];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$ %2.2f", [[product regularPrice] floatValue]]];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    [[cell labelPriceRegular] setAttributedText:attributeString];
    [[cell labelPriceSale] setText:[NSString stringWithFormat:@"$ %2.2f", [product.salePrice floatValue]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //TODO: ADD REMOVE ACTION HERE !!!!
    
    MCProduct *product = [self products][indexPath.row];
    
    [[MCDataProvider sharedInstance] deleteProduct:product];
    
    [self reloadItems];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MCProductDetailsViewController *productDetailsVC = [[MCProductDetailsViewController alloc] init];
    productDetailsVC.product = self.products[indexPath.row];
    [self.navigationController pushViewController:productDetailsVC animated:YES];
}

@end
