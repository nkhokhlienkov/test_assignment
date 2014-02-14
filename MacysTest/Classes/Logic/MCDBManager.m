//
//  DBManager.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/12/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCDBManager.h"
#import "FMDatabase.h"


@interface MCDBManager ()

@property (nonatomic, strong) FMDatabase *fmdb;

- (BOOL)openDB;

+ (NSArray *)convertStringToArray:(NSString *)string;
+ (NSString *)convertArrayToString:(NSArray *)string;

@end

@implementation MCDBManager

#pragma mark - Init

- (id)initWithDatabaseName:(NSString *)dbName {
    if (dbName.length < 1) {
        NSLog(@"SQLITE_ERROR_EMPTY_NAME");
        return nil;
    }
    
    self = [super init];
    if (self) {
        NSFileManager *fm = [NSFileManager defaultManager];
        
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        if (![fm fileExistsAtPath:documentsDirectory]) {
            [fm createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSString *path = [documentsDirectory stringByAppendingPathComponent:dbName];
        
        if (![fm fileExistsAtPath:path]) {
            NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:dbName ofType:@""];
            if (bundlePath == nil) {
                NSLog(@"SQLITE_ERROR_FILE_NOT_FOUND");
                
                return nil;
            }
            if (![fm copyItemAtPath:bundlePath toPath:path error:nil]) {
                NSLog(@"SQLITE_ERROR_FILE_NOT_COPIED");
                return nil;
            }
        }
        
        self.fmdb = [[FMDatabase alloc] initWithPath:path];
        if (self.fmdb == nil) {
            NSLog(@"SQLITE_ERROR_FMDB_NOT_CREATED");
            return nil;
        }
        
    }
    return self;
}

- (BOOL)openDB {
    if (![self.fmdb open]) {
        NSLog(@"DB Error %d: %@", [self.fmdb lastErrorCode], [self.fmdb lastErrorMessage]);
        return NO;
    }
    return YES;
}

+ (NSArray *)convertStringToArray:(NSString *)string {
    return [string componentsSeparatedByString:@","];
}

+ (NSString *)convertArrayToString:(NSArray *)array {
    return [array componentsJoinedByString:@","];
}

- (NSArray *)fetchProducts {
    NSMutableArray *array = [NSMutableArray array];
    
    if ([self openDB]) {
        FMResultSet *result = [self.fmdb executeQuery:@"SELECT * FROM product ORDER BY productId"];
        while (result.next) {
            
            MCProduct *product = [[MCProduct alloc] init];
            [result.resultDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if ([(NSString *)key isEqualToString:@"store"]) {
                    product.stores =  [MCDBManager convertStringToArray: (NSString*)obj];
                }
                else if ([(NSString *)key isEqualToString:@"color"]) {
                    product.colors =  [MCDBManager convertStringToArray: (NSString*)obj];
                }
                else if ([(NSString *)key isEqualToString:@"imageData"]) {
                    product.image = [UIImage imageWithData:obj];
                }
                else {
                    [product setValue:obj forKey:(NSString *)key];
                }
            }];
            [array addObject:product];
        }
        
        [self.fmdb close];
    }

    return array;
}

- (BOOL)storeNewProduct:(MCProduct *)product {
    if (!product) {
        return NO;
    }
    
    BOOL result = NO;
    
    if ([self openDB]) {
        NSString *color = [MCDBManager convertArrayToString: product.colors];
        NSString *store = [MCDBManager convertArrayToString: product.stores];
        NSData *imageData = UIImagePNGRepresentation(product.image);
        
        [self.fmdb beginTransaction];
        
        result = [self.fmdb executeUpdate:@"INSERT INTO product (name, description, regularPrice, salePrice, imageData, color, store)  VALUES (?, ?, ?, ?, ?, ?, ?)", product.name, product.description, product.regularPrice, product.salePrice, imageData, color, store];
        
        if (result) {
            [self.fmdb commit];
        }
        
        [self.fmdb close];
    }
    
    return result;
}

- (BOOL)deleteProduct:(MCProduct *)product
{
    if (!product) {
        return NO;
    }
    
    BOOL result = NO;
    
    if ([self openDB]) {
        [self.fmdb beginTransaction];
        
        result = [self.fmdb executeUpdate:@"DELETE FROM product WHERE productId = ?", product.productId];
        if (result) {
            [self.fmdb commit];
        }
        
        [self.fmdb close];
    }

    return result;
}

- (BOOL)updateProduct:(MCProduct *)product {
    if (!product) {
        return NO;
    }
    
    BOOL result = NO;
    
    if ([self openDB]) {
        NSString *color = [MCDBManager convertArrayToString: product.colors];
        NSString *store = [MCDBManager convertArrayToString: product.stores];
        NSData *imageData = UIImagePNGRepresentation(product.image);
        
        [self.fmdb beginTransaction];
        
        result = [self.fmdb executeUpdate:@"UPDATE product SET name=?, description=?, regularPrice=?, salePrice=?, color=?, store=?, imageData=? WHERE productId=?", product.name, product.description, product.regularPrice, product.salePrice, color, store, imageData, product.productId];
        
        if (result) {
            [self.fmdb commit];
        }
        
        [self.fmdb close];
    }
    
    return result;
}

@end
