//
//  PlayingCard.h
//  Matchismo
//
//  Created by Angela Hsu on 7/16/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "Card.h"
#import "PlayingCardMatchingGame.h"

@interface PlayingCard : Card




@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSArray *) rankStrings;
+ (NSUInteger)maxRank;
- (void)match:(PlayingCardMatchingGame *)game;

@end
