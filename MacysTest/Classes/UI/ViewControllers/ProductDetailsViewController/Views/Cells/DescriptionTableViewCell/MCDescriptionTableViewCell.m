//
//  MCDescriptionTableViewCell
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/13/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import "MCDescriptionTableViewCell.h"
#import "MCProduct.h"

typedef void(^Block)(id object, CGFloat height);

@interface MCDescriptionTableViewCell ()

@property (nonatomic, weak) IBOutlet UITextView *textViewDescription;
@property (nonatomic, strong) Block block;

@end

@implementation MCDescriptionTableViewCell

- (void)updateCellWithProduct:(MCProduct *)product {
    [[self textViewDescription] setText:[product description]];
    
    CGFloat fixedWidth = self.textViewDescription.frame.size.width;
    CGSize newSize = [self.textViewDescription sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.textViewDescription.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.textViewDescription.frame = newFrame;
    
    if ([self block]) {
        [self block](self, newFrame.size.height);
    }
}

- (void)heightWasChangedUsingBlock:(void (^)(id object, CGFloat height))block {
    [self setBlock:block];
}

@end
