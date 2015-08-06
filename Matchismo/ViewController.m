//
//  ViewController.m
//  Matchismo
//
//  Created by hangliu on 15/7/12.
//  Copyright © 2015年 MoonBright. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) BOOL start;
@property (weak, nonatomic) IBOutlet UILabel *stringLabel;

@end

@implementation ViewController

- (IBAction)resetGame:(id)sender {
    [self.game reset];
    self.start = NO;
    self.stringLabel.text = @"";
    [self updateUI];
}

- (IBAction)changMode:(id)sender {
    self.game.enableHardMode = self.modeSwitch.on;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:self.deck];
        _game.enableHardMode = NO;
    }
    return _game;
}

- (Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc]init];
    }
    return _deck;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.start = YES;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.modeSwitch.enabled = !self.start;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score : %ld",(long)self.game.score];
    self.stringLabel.text = self.game.descriptionString;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"" ;
}

- (UIImage *)backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
