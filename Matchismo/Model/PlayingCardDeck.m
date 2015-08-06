//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by hangliu on 15/7/12.
//  Copyright © 2015年 MoonBright. All rights reserved.
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    return self;
}



@end
