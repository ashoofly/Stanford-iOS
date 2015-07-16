//
//  Card.h
//  Matchismo
//
//  Created by Angela Hsu on 7/16/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;


@end
