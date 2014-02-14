//
//  DBManager.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/12/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCProduct.h"

@interface MCDBManager: NSObject

- (id)initWithDatabaseName:(NSString *)databaseName;

- (NSArray *)fetchProducts;

- (BOOL)storeNewProduct:(MCProduct *)dictionary;

- (BOOL)deleteProduct:(MCProduct *)product;

- (BOOL)updateProduct:(MCProduct *)product;

@end
