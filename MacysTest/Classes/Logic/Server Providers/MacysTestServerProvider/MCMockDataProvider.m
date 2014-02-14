//
//  MCMacysTestServerProvider.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/14/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCMockDataProvider.h"

@implementation MCMockDataProvider

- (void)getProductByType:(MCProductType)type withCompletion:(MCCompletionBlock)completion andFailureBlock:(MCFailureBlock)failure {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProductsData" ofType:@"plist"];
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *productInfoJSON = info[[NSString stringWithFormat:@"product_%d", type]];
    NSData *productData = [productInfoJSON dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:productData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    error ? failure(error): completion ([MCProduct productWithDictionary:jsonObject]);
}

@end
