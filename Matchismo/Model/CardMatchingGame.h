//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Angela Hsu on 7/17/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"



@interface CardMatchingGame : NSObject

/* abstract */

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic) NSInteger roundScore;
@property (nonatomic) NSInteger roundResult;
@property (nonatomic) NSInteger numMatch;

@end
