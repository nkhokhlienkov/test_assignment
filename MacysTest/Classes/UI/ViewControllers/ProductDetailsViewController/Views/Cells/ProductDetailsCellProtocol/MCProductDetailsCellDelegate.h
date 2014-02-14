//
//  MCProductDetailsCellDelegate.h
//  MacysTest
//
//  Created by Nikolay Khokhlienkov on 2/14/14.
//  Copyright (c) 2014 Nikolay Khokhlienkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MCProductDetailsCellUserActionType) {
    MCProductDetailsCellUserActionTypePhoto,
    MCProductDetailsCellUserActionTypeColor,
    MCProductDetailsCellUserActionTypeTitleChanged
};

@protocol MCProductDetailsCellDelegate <NSObject>


- (void)userActionWithType:(MCProductDetailsCellUserActionType)type userData:(id)userData;

@end
