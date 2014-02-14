//
//  MCProduct.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/12/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface MCProduct: NSObject

@property (nonatomic) NSNumber *productId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSNumber *regularPrice;
@property (nonatomic) NSNumber *salePrice;
@property (nonatomic) NSArray *colors;
@property (nonatomic) NSArray *stores;

- (id)initWithDictionary:(NSDictionary *)theDictionary;

+ (MCProduct *)productWithDictionary:(NSDictionary *)productInfo;

@end

