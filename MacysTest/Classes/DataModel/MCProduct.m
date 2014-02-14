//
//  MCProduct.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/12/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCProduct.h"

static NSString * const MCProductIDKey = @"id";
static NSString * const MCProductTitleKey = @"name";
static NSString * const MCProductDescriptionKey = @"description";
static NSString * const MCProductImageNameKey = @"imageName";
static NSString * const MCProductRegularPriceKey = @"regularPrice";
static NSString * const MCProductSalePriceKey = @"salePrice";
static NSString * const MCProductColorsKey = @"colors";
static NSString * const MCProductStoresKey = @"stores";

@implementation MCProduct

- (id)initWithDictionary:(NSDictionary *)theDictionary {
    if ((self = [super init])) {
        [self setupProductWithDictionary:theDictionary];
    }
    return self;
}

+ (MCProduct *)productWithDictionary:(NSDictionary *)productInfo {
    
    MCProduct *parsedProduct = [[MCProduct alloc] init];
    
    [parsedProduct setupProductWithDictionary:productInfo];
    
    return parsedProduct;
}

#pragma mark - Private

- (void)setupProductWithDictionary:(NSDictionary *)productInfo {
    [self setProductId:productInfo[MCProductIDKey]];
    [self setName:productInfo[MCProductTitleKey]];
    [self setDescription:productInfo[MCProductDescriptionKey]];
    [self setImage: [UIImage imageNamed: productInfo[MCProductImageNameKey]]];
    [self setRegularPrice:[NSNumber numberWithFloat:[productInfo[MCProductRegularPriceKey] floatValue]]];
    [self setSalePrice:[NSNumber numberWithInt:[productInfo[MCProductSalePriceKey] floatValue]]];
    
    NSMutableArray *arrayWithColors = [[NSMutableArray alloc] init];
    
    for (NSString *hexColor in productInfo[MCProductColorsKey]) {
        NSScanner *pScanner = [NSScanner scannerWithString: hexColor];
        
        unsigned int iValue;
        [pScanner scanHexInt: &iValue];
        
        NSNumber *colorNumber = [NSNumber numberWithInt:iValue];
        [arrayWithColors addObject:colorNumber];
    }

    [self setColors:arrayWithColors];
    [self setStores:productInfo[MCProductStoresKey]];
}

@end
