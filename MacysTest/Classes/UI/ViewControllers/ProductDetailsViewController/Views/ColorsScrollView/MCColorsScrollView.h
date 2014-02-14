//
//  MCColorsScrollView.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCColorsScrollViewDataSource;

@interface MCColorsScrollView: UIScrollView

@property (nonatomic, weak) IBOutlet NSObject <MCColorsScrollViewDataSource> *dataSource;

- (void)reloadData;

@end


@protocol MCColorsScrollViewDataSource

- (NSInteger)numberOfItems;
- (UIView *)viewForItemsAtIndex:(NSInteger)index;

@end
