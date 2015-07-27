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
    
    BOOL isFillSet = [self isSet:game.chosenCards property:FILL];
    BOOL isColorSet = [self isSet:game.chosenCards property:COLOR];
    BOOL isNumberSet = [self isSet:game.chosenCards property:NUMBER];
    BOOL isShapeSet = [self isSet:game.chosenCards property:SHAPE];
    
    if (isFillSet && isColorSet && isNumberSet && isShapeSet) {
        //it is a match
        game.roundScore = 10;
    }
    else {
        game.roundScore = -5;
        //unchoose them.
        //card.matched = NO;
        for (Card *card in game.chosenCards) {
            card.chosen = NO;
            NSLog(@"Unchose %@", card);
        }
    }
    
    
}
- (NSObject *) getProperty:(CardProperty) property {
    switch (property) {
        case FILL:
            return self.fill;
        case SHAPE:
            return self.shape;
        case NUMBER:
            return @(self.number);
        case COLOR:
            return self.color;
        default:
            return nil;
    }
}


- (BOOL) isSet:(NSArray *)cards property:(CardProperty) property {
    
    NSMutableArray *group = [[NSMutableArray alloc] init];
    for (SetCard *card in cards) {
        [group addObject:[card getProperty:property]];
    }
    int match = [[NSSet setWithArray:group] count];
    if (match == [SetCard maxNumber] || match == 1) {
        return YES;
    } else {
        return NO;
    }
}



@end
