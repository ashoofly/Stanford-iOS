//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Angela Hsu on 7/15/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *cardDeck;
@end

@implementation CardGameViewController

- (Deck *)cardDeck {
    if (!_cardDeck) {
        _cardDeck = [[PlayingCardDeck alloc] init];
    }
    return _cardDeck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:[self displayRandomCard] forState:UIControlStateNormal];
    }
    self.flipCount++;
}

- (NSString *)displayRandomCard {
    Card* card = [self.cardDeck drawRandomCard];
    return card.contents;
}


@end
