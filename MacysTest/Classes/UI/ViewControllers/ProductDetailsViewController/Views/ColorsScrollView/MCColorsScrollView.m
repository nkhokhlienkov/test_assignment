//
//  MCColorsScrollView.m
//  MacysTest
//
//  Created by  Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCColorsScrollView.h"

static CGFloat const ITEM_INTERVAL = 10.0;

@interface MCColorsScrollView()

@end

@implementation MCColorsScrollView

- (void)reloadData {
    NSInteger numberOfViews = [[self dataSource] numberOfItems];
    
    CGFloat xOffset = ITEM_INTERVAL;
    
    for (int i = 0; i < numberOfViews; i++) {
        
        [[self viewWithTag:i + 1] removeFromSuperview];
        
        UIView *view = [[self dataSource] viewForItemsAtIndex:i];
        [view setTag:i + 1];
        CGRect frame = [view frame];
        frame.origin.x = xOffset;
        [view setFrame:frame];
        
        xOffset += frame.size.width + ITEM_INTERVAL;
        
        [self addSubview:view];
    }
    
    [self setContentSize:CGSizeMake(xOffset, self.frame.size.height)];
}

@end
