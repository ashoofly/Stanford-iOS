//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Angela Hsu on 7/17/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

typedef NS_ENUM(NSInteger, MatchNumber) {
    TWO_CARD,
    THREE_CARD
};

typedef NS_ENUM(NSInteger, RoundResult) {
    ALL_RANKS_MATCH,
    ALL_SUITS_MATCH,
    SOME_RANKS_MATCH,
    SOME_SUITS_MATCH,
    NO_MATCH,
    TBD
};

@interface CardMatchingGame : NSObject



- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                         gameType:(NSInteger)multiple;

- (void) chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic) NSInteger multiple;
@property (nonatomic) NSInteger roundScore;
@property (nonatomic) RoundResult roundResult;
@end
