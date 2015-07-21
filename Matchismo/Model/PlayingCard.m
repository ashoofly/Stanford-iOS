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
static const int ALL_RANKS_MATCH_BONUS = 100;
static const int ALL_SUITS_MATCH_BONUS = 50;
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

- (int)match:(NSArray *)chosenCards {
    int score = 0;
    int maxMatch = [self findMaxMatch:chosenCards
                            criterion:RANK];
    NSLog(@"Max rank match count: %d", maxMatch);

    if (maxMatch == [chosenCards count] && [chosenCards count] > 2) {
        score += ALL_RANKS_MATCH_BONUS + maxMatch * RANK_MATCH_PTS;
        NSLog(@"All ranks matched! +%d", score);

    } else if (maxMatch > 1) {
        score = maxMatch * RANK_MATCH_PTS;
        NSLog(@"A match! +%d", score);
    } else {
        //look up suits.
        maxMatch = [self findMaxMatch:chosenCards
                            criterion:SUIT];
        NSLog(@"Max suit match count: %d", maxMatch);

        if (maxMatch == [chosenCards count] && [chosenCards count] >2) {
            score += ALL_SUITS_MATCH_BONUS + maxMatch * SUIT_MATCH_PTS;
            NSLog(@"All suits matched! +%d", score);
        } else if (maxMatch > 1) {
            score = maxMatch * SUIT_MATCH_PTS;
            NSLog(@"Match! +%d", score);
        } else {
            //if no rank OR suit,
            score -= MISMATCH_PENALTY;
            NSLog(@"No match! %d", score);
        }
    }
    return score;
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
        //NSLog(@"Looking for this key: %@", key);
        
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
