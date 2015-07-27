//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Angela Hsu on 7/23/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetDeck.h"
#import "SetCard.h"

#import "SetCardMatchingGame.h"

@implementation SetCardGameViewController

- (void) newGame {
    [super newGame];
    self.game = [[SetCardMatchingGame alloc] initWithCardCount:self.cardCount usingDeck:[self createDeck]];

}


- (Deck *)createDeck {
    return [[SetDeck alloc] init];
}


- (void)drawCardFace:(UIButton *)cardButton forCard:(Card *)card {
    SetCard *setCard = (SetCard *)card;
    [cardButton setAttributedTitle:[self titleForCard:setCard] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
}



- (NSAttributedString *)titleForCard:(Card *)card {
    SetCard *setCard = (SetCard *)card;
    NSMutableString *text = [NSMutableString string];
    for (int i=0; i<setCard.number; i++) {
        [text appendString:setCard.shape];
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttributes:@{
                NSFontAttributeName:[SetCardGameViewController getFontAttribute:setCard],
                NSForegroundColorAttributeName: [SetCardGameViewController getColorAttribute:setCard],
                NSUnderlineStyleAttributeName: @([SetCardGameViewController getUnderlineAttribute:setCard]),
                NSStrokeWidthAttributeName:[SetCardGameViewController getStrokeWidthAttribute:setCard],
                NSStrokeColorAttributeName: [UIColor blackColor]}
            range:NSMakeRange(0, [text length])];

    return string;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"chosen rounded" : @"cardfront"];
}


+ (UIColor *)getColorAttribute:(SetCard *)card {
    if ([card.color isEqualToString:@"RED"]) {
        return [UIColor redColor];
    }
    else if ([card.color isEqualToString:@"GREEN"]) {
        return [UIColor greenColor];
    }
    else if ([card.color isEqualToString:@"PURPLE"]) {
        return [UIColor purpleColor];
    }
    else {
        return [UIColor blackColor];
    }
}

+ (NSUnderlineStyle)getUnderlineAttribute:(SetCard *)card {
    if ([card.fill isEqualToString:@"STRIPED"]) {
        return NSUnderlineStyleThick;
    }
    else {
        return NSUnderlineStyleNone;
    }
    
}
    
+ (UIFont *)getFontAttribute:(SetCard *)card {
    if ([card.shape isEqualToString:@"●"]) {
        return [UIFont fontWithName:@"Helvetica" size:30];
    } else {
        return [UIFont fontWithName:@"Helvetica" size:20];
    }
}
    


+ (NSNumber *) getStrokeWidthAttribute:(SetCard *)card {
    if ([card.fill isEqualToString:@"OPEN"]) {
        return @-10;
    }
    else {
        return @0;
    }
}



@end
