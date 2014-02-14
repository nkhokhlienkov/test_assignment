//
//  MCProductShortcutCell.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCProductShortcutCell: UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageViewThumbnail;
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;
@property (nonatomic, weak) IBOutlet UILabel *labelPriceRegular;
@property (nonatomic, weak) IBOutlet UILabel *labelPriceSale;

@end
