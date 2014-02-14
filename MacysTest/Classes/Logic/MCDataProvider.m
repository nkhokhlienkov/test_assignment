//
//  MCDataProvider.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCDataProvider.h"
#import "MCMockDataProvider.h"
#import "MCDBManager.h"

@interface MCDataProvider ()

@property (nonatomic) MCMockDataProvider *mockDataProvider;
@property (nonatomic) MCDBManager *dbManager;

@end


@implementation MCDataProvider

- (instancetype)initUniqueInstance {
    self.mockDataProvider = [[MCMockDataProvider alloc] init];
    self.dbManager = [[MCDBManager alloc] initWithDatabaseName:@"MacysTestDatabase.sqlite"];
    return [super init];
}

+ (MCDataProvider *)sharedInstance {
    static MCDataProvider *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[super alloc] initUniqueInstance];
        }
    });
    return instance;
}

#pragma mark -
#pragma mark Public methods

- (void)addProduct:(MCProductType) productType {
    [self.mockDataProvider getProductByType:productType withCompletion: ^(MCProduct *result) {
        
        [self.dbManager storeNewProduct:result];
        
    } andFailureBlock:^(NSError *error) {
        //TODO: error handling
    }];
    
}

- (BOOL)deleteProduct:(MCProduct *)product {
    return [self.dbManager deleteProduct: product];
}

- (NSArray *)getAllProducts {
    return [self.dbManager fetchProducts];
}

- (BOOL)updateProduct:(MCProduct *)product
{
     return [self.dbManager updateProduct:product];
}

@end
