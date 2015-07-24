//
//  PlayingCardMatchingGame.h
//  Matchismo
//
//  Created by Angela Hsu on 7/23/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "CardMatchingGame.h"

@interface PlayingCardMatchingGame : CardMatchingGame

typedef NS_ENUM(NSInteger, RoundResult) {
    ALL_RANKS_MATCH,
    ALL_SUITS_MATCH,
    SOME_RANKS_MATCH,
    SOME_SUITS_MATCH,
    NO_MATCH,
    TBD
};



@end
