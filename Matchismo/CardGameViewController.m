//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Angela Hsu on 7/15/15.
//  Copyright (c) 2015 Optaros. All rights reserved.
//

/* TODO:
 1. Label needs to start off with blank.
 2. Label needs to clear itself. 
 3. Score detail points are erroneous. ALL MATCH when NO MATCH, etc.
 
 
 */


#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *startGame;
@property (nonatomic) NSInteger multiple;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *suitRankLabel;
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
    self.segmentedControl.userInteractionEnabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self updateScoreDetails];
}
- (IBAction)startGameButton:(UIButton *)sender {
    self.segmentedControl.userInteractionEnabled = YES;
    [self resetGame];
}

- (IBAction)gameTypeAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.multiple = 2;
        NSLog(@"User wants 2-card game.");
    } else if (sender.selectedSegmentIndex == 1) {
        self.multiple = 3;
        NSLog(@"User wants 3-card game.");
    }
    [self resetGame];
   }

- (void)resetGame {
    [self setGame];
    [self updateUI];
    [self updateScoreDetails];
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        PlayingCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

- (void)updateScoreDetails {
    [self.suitRankLabel setText:@""];
    NSMutableString *cards = [NSMutableString string];
    for (PlayingCard *card in self.game.chosenCards) {
        [cards appendString:[NSString stringWithFormat:@"%@ %@  ", [PlayingCard rankStrings][card.rank], card.suit]];
    }
    if (self.game.roundResult != TBD) {
        switch (self.game.roundResult) {
            case ALL_RANKS_MATCH:
                [cards appendString:[NSString stringWithFormat:@"All ranks matched! +%ld", self.game.roundScore]];
                break;
            case SOME_RANKS_MATCH:
                [cards appendString:[NSString stringWithFormat:@"Some ranks matched! +%ld", self.game.roundScore]];
                break;
            case SOME_SUITS_MATCH:
                [cards appendString:[NSString stringWithFormat:@"Some suits matched! +%ld", self.game.roundScore]];
                break;
            case ALL_SUITS_MATCH:
                [cards appendString:[NSString stringWithFormat:@"All suits matched! +%ld", self.game.roundScore]];
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

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents: @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront": @"cardback"];
}



@end
