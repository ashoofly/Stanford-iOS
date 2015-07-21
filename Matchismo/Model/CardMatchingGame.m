//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Angela Hsu on 7/17/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic) NSInteger multiple;
@property (nonatomic) NSInteger roundScore;
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
        for (PlayingCard *card in self.chosenCards) {
            card.chosen = NO;
            NSLog(@"Unchoosing card %lu of %@", card.rank, card.suit);
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
            NSLog(@"-1 for choosing. Current score: %ld", (long)self.score);
            
            [self.chosenCards addObject:card];
            NSLog(@"Chosen cards:");
            for (PlayingCard *card in self.chosenCards) {
                NSLog(@"%lu %@", (unsigned long)card.rank, card.suit);
            }
            
            if ([self.chosenCards count] == self.multiple) {
                int roundScore = [card match:self.chosenCards];
                self.score += roundScore;
                NSLog(@"Total score after round: %ld", (long)self.score);

                if (roundScore > 0) {
                    /* at least 1 match */
                    for (PlayingCard *card in self.chosenCards) {
                        card.matched = YES;
                        NSLog(@"Chosen card %lu of %@ is matched and out of play.", card.rank, card.suit);
                    }
                    self.chosenCards = [[NSMutableArray alloc] init];
                }
            }
        }
    }
}

@end
