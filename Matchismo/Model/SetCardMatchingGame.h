//
//  SetCardMatchingGame.h
//  Matchismo
//
//  Created by Angela Hsu on 7/24/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "CardMatchingGame.h"

@interface SetCardMatchingGame : CardMatchingGame

typedef NS_ENUM(NSInteger, CardProperty) {
    FILL,
    SHAPE,
    COLOR,
    NUMBER
};


@end
