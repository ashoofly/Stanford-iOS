//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by Angela Hsu on 7/24/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "SetCardMatchingGame.h"

#import "SetCard.h"

@implementation SetCardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    
    self = [super initWithCardCount:count usingDeck:deck];
    if (self) {
        self.roundResult = UNDEFINED;
        self.numMatch = 3;
    }
    
    return self;
}

@end
