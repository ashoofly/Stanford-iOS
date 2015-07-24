//
//  SetCardGameViewController.h
//  Matchismo
//
//  Created by Angela Hsu on 7/23/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "CardGameViewController.h"
#import "SetCardMatchingGame.h"

@interface SetCardGameViewController : CardGameViewController

- (void)drawCardFace:(UIButton *)cardButton forCard:(Card *)card;

@end
