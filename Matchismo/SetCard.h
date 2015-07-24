//
//  SetCard.h
//  Matchismo
//
//  Created by Angela Hsu on 7/23/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "Card.h"
#import "SetCardMatchingGame.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *fill;
@property (nonatomic) int number;
@property (strong, nonatomic) NSString *shape;

+ (NSArray *)validColors;
+ (NSArray *)validShapes;
+ (NSArray *)validFill;
+ (int)maxNumber;
- (void)match:(SetCardMatchingGame *)game;

@end
