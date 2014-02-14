//
//  MCViewController.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/12/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCProductDetailsViewController.h"
#import "MCProduct.h"
#import "MCProductDetailsCellProtocol.h"
#import "MCTitleTableViewCell.h"
#import "MCDescriptionTableViewCell.h"
#import "MCStoresTableViewCell.h"
#import "MCImageGalleryView.h"
#import "MCStoresListViewController.h"
#import "MCDataProvider.h"

static NSInteger const CELLS_COUNT = 3;

static CGFloat const MCTitleTableViewCellHeight         = 360.0;
static CGFloat const MCStoresTableViewCellHeight        = 44.0;
static CGFloat const MCDescriptionTableViewellHeight    = 44.0;


@interface MCProductDetailsViewController ()

@property (nonatomic) IBOutlet MCImageGalleryView *imageGalleryView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *cellHeights;
@property (nonatomic) NSArray *cellIdentifiers;
@property (nonatomic, assign) BOOL isEditModeEnabled;
@end

@implementation MCProductDetailsViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self initialize];
    [self initializeImageGalleryView];
}

#pragma mark - Private -


- (void)initialize {
    
    [self setCellHeights:@[@(MCTitleTableViewCellHeight), @(MCDescriptionTableViewellHeight), @(MCStoresTableViewCellHeight)]];
    [self setCellIdentifiers:@[[MCTitleTableViewCell class], [MCDescriptionTableViewCell class], [MCStoresTableViewCell class]]];


    [self setIsEditModeEnabled:FALSE];
    [self setRightBarButtonItemWithTitle:@"Edit"];
}

- (void)initializeImageGalleryView {
    
    [self setImageGalleryView:[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MCImageGalleryView class]) 
                                                            owner:self 
                                                          options:nil][0]];
    [[self view] addSubview:[self imageGalleryView]];
}


- (void)setRightBarButtonItemWithTitle:(NSString *)title {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStyleBordered 
                                                            target:self 
                                                            action:@selector(editButtonWasClicked)];
    
    [[self navigationItem] setRightBarButtonItem:item];
}

- (void)editButtonWasClicked {
    
    if ([self isEditModeEnabled]) {
        [self setRightBarButtonItemWithTitle:@"Edit"];
    } else {
        [self setRightBarButtonItemWithTitle:@"Done"];
    }
    
    [self setIsEditModeEnabled:![self isEditModeEnabled]];
    
    [[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CELLS_COUNT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self cellHeights][indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell <MCProductDetailsCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self cellIdentifiers][indexPath.row])
                                                     owner:self
                                                   options:nil];
        
        cell = (UITableViewCell <MCProductDetailsCellProtocol> *)[nib objectAtIndex:0];
        [cell setDelegate:self];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    [cell setTag:indexPath.row];
    
    // For description cell height updating ..
    if ([cell respondsToSelector:@selector(heightWasChangedUsingBlock:)]) {
        
        __weak typeof(tableView) weakTableView = tableView;
        
        [cell heightWasChangedUsingBlock:^(UITableViewCell *cell, CGFloat height) {
            if ([[self cellHeights][indexPath.row] floatValue] != height) {
              
                NSMutableArray *heights = [NSMutableArray arrayWithArray:[self cellHeights]];
                [heights replaceObjectAtIndex:indexPath.row withObject:@(height)];
                [self setCellHeights:[NSArray arrayWithArray:heights]];
                
                [weakTableView reloadData];
            }
        }];
    }
    
    if ([cell respondsToSelector:@selector(updateCellWithEditMode:)]) {
        
        [cell updateCellWithEditMode:[self isEditModeEnabled]];
    }
    
    [cell updateCellWithProduct:[self product]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cellIdentifier = [self cellIdentifiers][indexPath.row];
    if ([cellIdentifier isSubclassOfClass:[MCStoresTableViewCell class]]) {
        
        NSString *nibName = NSStringFromClass([MCStoresListViewController class]);
        MCStoresListViewController *storesListVC = [[MCStoresListViewController alloc] initWithNibName:nibName bundle:nil];
        [storesListVC setProduct:[self product]];
        [[self navigationController] pushViewController:storesListVC animated:YES];
    }
}


#pragma mark - MCProductDetailsCellDelegate

- (void)userActionWithType:(MCProductDetailsCellUserActionType)type userData:(id)userData {
    
    switch (type) {
        case MCProductDetailsCellUserActionTypePhoto: {
            [[self imageGalleryView] setImage:(UIImage *)userData];
            [[self imageGalleryView] show];
            break;
        }
        case MCProductDetailsCellUserActionTypeColor: {
            break;
        }
        case MCProductDetailsCellUserActionTypeTitleChanged: {
            NSString *newProductTitle = (NSString *)userData;
            self.product.name = newProductTitle;
            
            [[MCDataProvider sharedInstance] updateProduct:self.product];
            
            [[self tableView] reloadData];
            
            break;
        }
            
        default:
            break;
    }
}

@end
