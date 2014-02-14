//
//  MCViewController.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/12/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCHomeViewController.h"
#import "MCProductListViewController.h"
#import "MCProduct.h"


#import "MCDataProvider.h"

@interface MCHomeViewController ()

@end

@implementation MCHomeViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)createProductAction:(UIButton *)sender {
    [[MCDataProvider sharedInstance] addProduct:[sender tag]];
}

- (IBAction)showProductsAction:(UIButton *)sender {
    MCProductListViewController *vc = [[MCProductListViewController alloc] initWithNibName:nil
                                                                                    bundle:nil];
    
    [[self navigationController] pushViewController:vc animated:TRUE];
}

@end
