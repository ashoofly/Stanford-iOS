//
//  Card.m
//  Matchismo
//
//  Created by Angela Hsu on 7/16/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

- (NSString *) contents {
    return @"";
}




@end
