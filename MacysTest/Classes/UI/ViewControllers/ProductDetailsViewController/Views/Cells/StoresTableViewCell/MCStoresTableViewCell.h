//
//  MCStoresTableViewCell
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCProductDetailsCellProtocol.h"
#import "MCProductDetailsCellDelegate.h"

@interface MCStoresTableViewCell: UITableViewCell <MCProductDetailsCellProtocol>

@property (nonatomic, weak) NSObject <MCProductDetailsCellDelegate> *delegate;

@end
