//
//  MCImageGalleryView.m
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/14/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCImageGalleryView.h"

@interface MCImageGalleryView()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation MCImageGalleryView

- (void)awakeFromNib {
    
    [self setAlpha:0.0];
}


- (void)setImage:(UIImage *)image {
    
    [[self imageView] setImage:image];
}


- (void)show {
    
    [self setAlpha:0.0];
    
    [UIView animateWithDuration:1.0 
                     animations:^{
                         [self setAlpha:1.0]; 
                     }];
}

- (void)hide {
    
    [self setAlpha:1.0];
    
    [UIView animateWithDuration:1.0 
                     animations:^{
                         [self setAlpha:0.0]; 
                     }];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hide];
}

@end
