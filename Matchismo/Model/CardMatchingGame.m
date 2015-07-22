//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Angela Hsu on 7/17/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "CardGameViewController.h"

@interface CardMatchingGame()

@end


@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *) chosenCards {
    if (!_chosenCards) {
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
}




- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck gameType:(NSInteger)multiple {
    
    self = [super init];
    if (self) {
        self.multiple = multiple;
        self.roundResult = TBD;
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }

    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index {
    
    if ([self.chosenCards count]== self.multiple) {
        /* reset */
        for (Card *card in self.chosenCards) {
            if (!card.isMatched) {
                card.chosen = NO;
            }
        }
        self.chosenCards = [[NSMutableArray alloc] init];
    }
    
    Card *card = [self cardAtIndex:index];
    
    /* only do something if card is still in play */
    if (!card.isMatched) {
        
        if (card.isChosen) {
            /* unchoose card */
            card.chosen = NO;
            [self.chosenCards removeObject:card];
            
        } else {
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
            
            [self.chosenCards addObject:card];

            if ([self.chosenCards count] == self.multiple) {

                if ([card isMemberOfClass:[PlayingCard class]]) {
                    [(PlayingCard *)card match:self];
                } else {
                    [card match:self.chosenCards];
                }
                self.score += self.roundScore;

                if (self.roundScore > 0) {
                    /* at least 1 match */
                    for (PlayingCard *card in self.chosenCards) {
                        card.matched = YES;
                    }
                }
            }
        }
    }
}

@end
