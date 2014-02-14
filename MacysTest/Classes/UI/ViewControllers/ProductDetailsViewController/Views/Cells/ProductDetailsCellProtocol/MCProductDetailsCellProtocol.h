//
//  MCProductDetailsCellProtocol.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCProductDetailsCellDelegate.h"

@class MCProduct;

@protocol MCProductDetailsCellProtocol <NSObject>

- (void)updateCellWithProduct:(MCProduct *)product;

- (void)setDelegate:(NSObject <MCProductDetailsCellDelegate> *)delegate;

@optional

- (void)heightWasChangedUsingBlock:(void (^)(id object, CGFloat height))block;
- (void)updateCellWithEditMode:(BOOL)editMode;

@end
