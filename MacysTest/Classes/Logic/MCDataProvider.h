//
//  MCDataProvider.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMockDataProvider.h"

@class MCProduct;

@interface MCDataProvider: NSObject

+ (MCDataProvider *)sharedInstance;

- (void)addProduct:(MCProductType)productStyle;

- (BOOL)deleteProduct:(MCProduct *)product;

- (NSArray *)getAllProducts;

- (BOOL)updateProduct:(MCProduct *)product;


+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end
