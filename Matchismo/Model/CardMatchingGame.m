//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by hangliu on 15/8/2.
//  Copyright (c) 2015年 MoonBright. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

- (void)reset
{
    for (Card *card in self.cards) {
        card.matched = NO;
        card.chosen = NO;
    }
    self.score = 0;
    self.descriptionString = @"";
    self.matchedCount = 0;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            if (!self.enableHardMode) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    otherCard.matched = YES;
                    self.descriptionString = [NSString stringWithFormat:@"Matched %@%@",card.contents,otherCard.contents];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    otherCard.chosen = NO;
                    self.descriptionString = [NSString stringWithFormat:@"M%@%@don't match",card.contents,otherCard.contents];
                }
                    break; //can only choose 2 cards for now
                }
               
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            } else {
                NSMutableArray *array = [[NSMutableArray alloc]init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [array addObject:otherCard];
                        if ([array count] == 2) {
                            int matchScore = [card match:array];
                            if (matchScore) {
                                self.score += matchScore;
                                card.matched = YES;
                                for (Card *card in array) {
                                    card.matched = YES;
                                }
                                [array removeAllObjects];
                                self.matchedCount += 3;
                                if (self.matchedCount == [self.cards count]) {
                                    self.descriptionString = @"GAME IS OVER";
                                }
                            } else {
                                self.score -= MISMATCH_PENALTY;
                                for (Card *card in array) {
                                    card.chosen = NO;
                                }
                            }
                            break;
                        }
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; // super's designated initializer
    
    if (self) {
        for (int i = 0 ; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
