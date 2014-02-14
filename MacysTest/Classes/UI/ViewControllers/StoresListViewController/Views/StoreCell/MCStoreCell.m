//
//  MCStoreCell.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/14/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCStoreCell.h"

@interface MCStoreCell ()

@property (nonatomic, weak) IBOutlet UILabel *labelName;

@end

@implementation MCStoreCell

- (void)setStoreName:(NSString *)name {
    [[self labelName] setText:name];
}

@end
