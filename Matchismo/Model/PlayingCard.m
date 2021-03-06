//
//  PlayingCard.m
//  Matchismo
//
//  Created by Angela Hsu on 7/16/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

static const int RANK_MATCH_PTS = 4;
static const int SUIT_MATCH_PTS = 1;
static const int MISMATCH_PENALTY = 1;

typedef NS_ENUM(NSInteger, Criterion) {
    RANK,
    SUIT
};

- (bool)isEqual:(PlayingCard *)otherCard {
    if (self.rank == otherCard.rank && self.suit == otherCard.suit) {
        return YES;
    } else {
        return NO;
    }
}

- (void)match:(PlayingCardMatchingGame *)game {
    game.roundScore = 0;
    game.roundResult = TBD;
    int maxMatch = [self findMaxMatch:game.chosenCards
                            criterion:RANK];
    NSLog(@"Max rank match count: %d", maxMatch);
    
    if (maxMatch == [game.chosenCards count]) {
        game.roundScore = maxMatch * RANK_MATCH_PTS;
        game.roundResult = RANKS_MATCH;
        NSLog(@"Rank matched! +%ld", (long)game.roundScore);
    } else {
        //look up suits.
        maxMatch = [self findMaxMatch:game.chosenCards
                            criterion:SUIT];
        NSLog(@"Max suit match count: %d", maxMatch);

        if (maxMatch == [game.chosenCards count]) {
                game.roundScore = maxMatch * SUIT_MATCH_PTS;
                game.roundResult = SUITS_MATCH;
                NSLog(@"Suits matched! +%ld", (long)game.roundScore);

        } else {
            //if no rank OR suit,
            game.roundScore -= MISMATCH_PENALTY;
            game.roundResult = NO_MATCH;
            NSLog(@"No match! %ld", (long)game.roundScore);
        }
    }
}

- (int) findMaxMatch:(NSArray *)chosenCards criterion:(Criterion)theCriterion {
    
    NSMutableDictionary *counts = [NSMutableDictionary dictionary];
    NSString *key = [[NSString alloc] init];
    NSNumber *value = [[NSNumber alloc] init];

    for (PlayingCard *card in chosenCards) {
        if (theCriterion == RANK) {
            key = [NSString stringWithFormat:@"%lu", card.rank];
        } else if (theCriterion == SUIT) {
            key = card.suit;
        }
        
        if ((value = [counts objectForKey:key])) {
            [counts setObject:[NSNumber numberWithInt:([value intValue]+1)] forKey:key];
        } else {
            [counts setObject:[NSNumber numberWithInt:1] forKey:key];
        }
    }
    NSArray *keys = [counts keysSortedByValueUsingComparator:^(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
                     
    return [counts[[keys firstObject]] intValue];
}


- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank<= [PlayingCard maxRank]) {
        _rank = rank;
    }
}








@end
