//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Angela Hsu on 7/22/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *suitRankLabel;
@end

@implementation PlayingCardGameViewController


- (void) newGame {
    [super newGame];
    self.game = [[PlayingCardMatchingGame alloc] initWithCardCount:self.cardCount usingDeck:[self createDeck]];
}


- (Deck *)createDeck {
     return [[PlayingCardDeck alloc] init];
}

- (void)updateScoreDetails {
    [self.suitRankLabel setText:@""];
    NSMutableString *cards = [NSMutableString string];
    for (PlayingCard *card in self.game.chosenCards) {
        [cards appendString:[NSString stringWithFormat:@"%@ %@  ", [PlayingCard rankStrings][card.rank], card.suit]];
    }
    if (self.game.roundResult != TBD) {
        switch (self.game.roundResult) {
            case RANKS_MATCH:
                [cards appendString:[NSString stringWithFormat:@"Ranks matched! +%ld", self.game.roundScore]];
                break;
            case SUITS_MATCH:
                [cards appendString:[NSString stringWithFormat:@"Suits matched! +%ld", self.game.roundScore]];
                break;
            case NO_MATCH:
                [cards appendString:[NSString stringWithFormat:@"No cards matched! %ld", self.game.roundScore]];
                break;
            default:
                break;
        }
    }
    [self.suitRankLabel setText:cards];
    self.game.roundResult = TBD;
    
}

- (void)drawCardFace:(UIButton *)cardButton forCard:(Card *)card {
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents: @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront": @"cardback"];
}

@end
