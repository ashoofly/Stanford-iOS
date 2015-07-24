//
//  PlayingCardMatchingGame.m
//  Matchismo
//
//  Created by Angela Hsu on 7/23/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "PlayingCardMatchingGame.h"

@implementation PlayingCardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    
    self = [super initWithCardCount:count usingDeck:deck];
    if (self) {
        self.roundResult = TBD;
    }
    
    return self;
}

@end
