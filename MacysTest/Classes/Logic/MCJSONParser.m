//
//  MCJSONParser.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCJSONParser.h"
#import <Foundation/NSJSONSerialization.h>

@implementation MCJSONParser

- (id)parseDataToObject:(NSData *)theData {
    NSError *error;

    id jsonObject = [NSJSONSerialization JSONObjectWithData:theData
                                                       options:NSJSONReadingAllowFragments
                                                         error:&error];
    
    if (!jsonObject) {
        NSLog(@"Got an error: %@", error);
    }
    
    return jsonObject;
}

@end
