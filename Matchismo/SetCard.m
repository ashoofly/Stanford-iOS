//
//  SetCard.m
//  Matchismo
//
//  Created by Angela Hsu on 7/23/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


+ (int)maxNumber {
    return 3;
}

+ (NSArray *)validColors {
    return @[@"RED", @"GREEN", @"PURPLE"];
}

+ (NSArray *)validFill {
    return @[@"SOLID", @"STRIPED", @"OPEN"];
}

+ (NSArray *)validShapes {
    return @[@"▲", @"●", @"■"];
}

- (void)match:(SetCardMatchingGame *)game {
    game.roundScore = 0;
    
    for (SetCard *card in game.chosenCards) {
        //BOOL isFillSet = [self isSet:game.chosenCards];
        
        
        
        
        
        //take off copy & paste and generalize to isSet...
        
        if ([self fillSet:game.chosenCards] && [self shapeSet:game.chosenCards] && [self numSet:game.chosenCards] && [self colorSet:game.chosenCards]) {
            //it is a match
        }
        else {
            //unchoose them.
        }
    }
    
    
}

- (void) getProperty:(Card *)card property:(CardProperty *)property {
    
}

- (BOOL) fillSet:(NSArray *)cards {
    NSMutableArray *fill = [[NSMutableArray alloc] init];
    for (SetCard *card in cards) {
        [fill addObject:card.fill];
    }
    int match = [[NSSet setWithArray:fill] count];
    if (match == [SetCard maxNumber] || match == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) shapeSet:(NSArray *)cards {
    NSMutableArray *shape = [[NSMutableArray alloc] init];
    for (SetCard *card in cards) {
        [shape addObject:card.shape];
    }
    int match = [[NSSet setWithArray:shape] count];
    if (match == [SetCard maxNumber] || match == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) numSet:(NSArray *)cards {
    NSMutableArray *num = [[NSMutableArray alloc] init];
    for (SetCard *card in cards) {
        [num addObject:@(card.number)];
    }
    int match = [[NSSet setWithArray:num] count];
    if (match == [SetCard maxNumber] || match == 1) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL) colorSet:(NSArray *)cards {
    NSMutableArray *color = [[NSMutableArray alloc] init];
    for (SetCard *card in cards) {
        [color addObject:card.color];
    }
    int match = [[NSSet setWithArray:color] count];
    if (match == [SetCard maxNumber] || match == 1) {
        return YES;
    } else {
        return NO;
    }
}



@end
