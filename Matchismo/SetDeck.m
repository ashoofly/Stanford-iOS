//
//  SetDeck.m
//  Matchismo
//
//  Created by Angela Hsu on 7/23/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "SetDeck.h"

@implementation SetDeck


- (instancetype)init {
    self = [super init];
    if (self) {
        for (int number = 1; number<=[SetCard maxNumber]; number++) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *fill in [SetCard validFill]) {
                    for (NSString *shape in [SetCard validShapes]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.fill = fill;
                        card.color = color;
                        card.shape = shape;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
        
    }
    
    return self;
}





@end
