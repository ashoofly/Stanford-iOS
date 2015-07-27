//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Angela Hsu on 7/15/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController


- (void) viewDidLoad {
    [self resetGame];
}

- (CardMatchingGame *) game {
    if (!_game) {
        [self newGame];
    }
    return _game;
}

- (void) newGame {
    self.cardCount = [self.cardButtons count];
}

- (Deck *)createDeck {  //abstract
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self updateScoreDetails];
}

- (IBAction)startGameButton:(UIButton *)sender {
    [self resetGame];
}


- (void)resetGame {
    [self newGame];
    [self updateUI];
    [self updateScoreDetails];
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [self drawCardFace:cardButton forCard:card];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}


- (void)drawCardFace:(UIButton *)cardButton forCard:(Card *)card {
    //abstract
}

- (void)updateScoreDetails {
    //abstract - instantiated in subclass
}





@end
