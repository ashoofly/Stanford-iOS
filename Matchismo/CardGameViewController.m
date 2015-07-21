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
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *startGame;
@property (nonatomic) NSInteger multiple;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game {
    if (!_game) {
        self.multiple = 2; //default
        [self setGame];
    }
    return _game;
}

- (void) setGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] gameType:self.multiple];
}
                 
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (IBAction)startGameButton:(UIButton *)sender {
    [self setGame];
    [self updateUI];
}

- (IBAction)gameTypeAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.multiple = 2;
        NSLog(@"User wants 2-card game.");
    } else if (sender.selectedSegmentIndex == 1) {
        self.multiple = 3;
        NSLog(@"User wants 3-card game.");
    }
    [self setGame];
    [self updateUI];
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}



- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents: @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront": @"cardback"];
}



@end
