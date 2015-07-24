//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Angela Hsu on 7/15/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//
//  Abstract class. Subclasses must implement createDeck: and updateScoreDetails:.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) NSInteger cardCount;

- (void)newGame;

/* abstract */
- (Deck *)createDeck;
- (void)updateScoreDetails;
- (void)drawCardFace:(UIButton *)cardButton forCard:(Card *)card;



@end

