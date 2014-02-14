//
//  MCTitleTableViewCell.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCTitleTableViewCell.h"
#import "MCProduct.h"

@interface MCTitleTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelTitle;
@property (nonatomic, weak) IBOutlet UILabel *labelRegularPrice;
@property (nonatomic, weak) IBOutlet UILabel *labelSalePrice;
@property (nonatomic, weak) IBOutlet UIImageView *imageViewPhoto;
@property (nonatomic, weak) IBOutlet MCColorsScrollView *scrollViewColors;
@property (nonatomic, weak) IBOutlet UIButton *buttonEditTitle;

@property (nonatomic) NSArray *colors;
@property (nonatomic) UIButton *buttonSelectedColor;

@end

@implementation MCTitleTableViewCell

- (void)updateCellWithProduct:(MCProduct *)product {
    [[self labelTitle] setText:[product name]];
    
    UIImage *image = [product image];
    
    if (image == nil) {
        image = [UIImage imageNamed:@"product_placeholder"];
    }
    
    [[self imageViewPhoto] setImage:image];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"$ %2.2f", [[product regularPrice] floatValue]]];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    
    [[self labelRegularPrice] setAttributedText:attributeString];
    
    [[self labelSalePrice] setText:[NSString stringWithFormat:@"$ %2.2f", [[product salePrice] floatValue]]];
    
    [self setColors:[product colors]];
    [[self scrollViewColors] reloadData];
}

- (void)updateCellWithEditMode:(BOOL)editMode {
    [[self buttonEditTitle] setHidden:!editMode];
}


#pragma mark - Actions

- (IBAction)photoButtonWasClicked:(id)sender {
    [[self delegate] userActionWithType:MCProductDetailsCellUserActionTypePhoto 
                               userData:[[self imageViewPhoto] image]];
}

- (IBAction)editTitleButtonWasClicked:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter new name for product here" 
                                                    message:@"" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Done", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    
    [[alert textFieldAtIndex:0] setText:[[self labelTitle] text]];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[self delegate] userActionWithType:MCProductDetailsCellUserActionTypeTitleChanged 
                                   userData:[[alertView textFieldAtIndex:0] text]];
    }
}

#pragma mark - MCColorsScrollViewDataSource

- (NSInteger)numberOfItems {
    return [[self colors] count];
}

- (UIView *)viewForItemsAtIndex:(NSInteger)index {
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [[view layer] setBorderColor:[UIColor blackColor].CGColor];
    [[view layer] setBorderWidth:1.0];
    [view setBackgroundColor:UIColorFromRGB([[self colors][index] integerValue])];
    [view addTarget:self action:@selector(colorWasSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    return  view;
}

- (void)colorWasSelected:(UIButton *)buttonColor {
    [[[self buttonSelectedColor] layer] setBorderWidth:1.];
    [self setButtonSelectedColor:buttonColor];
    [[[self buttonSelectedColor] layer] setBorderWidth:3.];
    
    [[self delegate] userActionWithType:MCProductDetailsCellUserActionTypeColor 
                               userData:[buttonColor backgroundColor]];
}

@end
