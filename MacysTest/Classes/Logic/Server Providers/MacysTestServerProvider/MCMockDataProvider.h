//
//  MCMacysTestServerProvider.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/14/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MCProduct.h"

typedef NS_ENUM(NSInteger, MCProductType) {
    MCProductTypeFirst = 1,
    MCProductTypeSecond = 2,
    MCProductTypeThird = 3
};

typedef void (^MCCompletionBlock)(MCProduct * result);
typedef void (^MCFailureBlock)(NSError* error);

@interface MCMockDataProvider: NSObject

- (void)getProductByType:(MCProductType)type withCompletion:(MCCompletionBlock)completion andFailureBlock: (MCFailureBlock)failure;

@end
