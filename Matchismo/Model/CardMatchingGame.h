//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Angela Hsu on 7/17/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import <Foundation/Foundation.h>
# import "Deck.h"


@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
