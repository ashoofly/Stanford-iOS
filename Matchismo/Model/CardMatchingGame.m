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

- (PlayingCard *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index {
    
    if ([self.chosenCards count]== self.multiple) {
        /* reset */
        for (PlayingCard *card in self.chosenCards) {
            if (!card.isMatched) {
                card.chosen = NO;
                NSLog(@"Unchoosing card %lu of %@", card.rank, card.suit);
            }
        }
        self.chosenCards = [[NSMutableArray alloc] init];
    }
    
    PlayingCard *card = [self cardAtIndex:index];
    
    /* only do something if card is still in play */
    if (!card.isMatched) {
        
        if (card.isChosen) {
            /* unchoose card */
            card.chosen = NO;
            [self.chosenCards removeObject:card];
            
        } else {
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
            NSLog(@"-1 for choosing. Current score: %ld", (long)self.score);
            
            [self.chosenCards addObject:card];
            NSLog(@"Chosen cards:");
            for (PlayingCard *card in self.chosenCards) {
                NSLog(@"%lu %@", (unsigned long)card.rank, card.suit);
            }
            
            if ([self.chosenCards count] == self.multiple) {
                //- (void)match:(NSArray *)chosenCards ofGame:(CardMatchingGame *)game;

                [card match:self];
                self.score += self.roundScore;
                NSLog(@"Total score after round: %ld", (long)self.score);

                if (self.roundScore > 0) {
                    /* at least 1 match */
                    for (PlayingCard *card in self.chosenCards) {
                        card.matched = YES;
                        NSLog(@"Chosen card %lu of %@ is matched and out of play.", card.rank, card.suit);
                    }
                }
            }
        }
    }
}

@end
