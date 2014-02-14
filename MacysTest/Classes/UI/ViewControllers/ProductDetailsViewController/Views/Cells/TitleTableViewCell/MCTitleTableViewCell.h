//
//  MCTitleTableViewCell.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProductDetailsCellProtocol.h"
#import "MCColorsScrollView.h"
#import "MCProductDetailsCellDelegate.h"

@interface MCTitleTableViewCell: UITableViewCell <MCProductDetailsCellProtocol, MCColorsScrollViewDataSource>

@property (nonatomic, weak) NSObject <MCProductDetailsCellDelegate> *delegate;

@end
