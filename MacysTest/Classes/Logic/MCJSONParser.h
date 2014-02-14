//
//  MCJSONParser.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCJSONParser: NSObject

- (id)parseDataToObject:(NSData *)theData;

@end
