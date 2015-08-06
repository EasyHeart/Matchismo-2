//
//  PlayingCard.m
//  Matchismo
//
//  Created by hangliu on 15/7/12.
//  Copyright © 2015年 MoonBright. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString: otherCard.suit]) {
            score = 1;
        } else if (self.rank == otherCard.rank){
            score = 4;
        }
    } else if ([otherCards count] == 2){
        PlayingCard *card1 = otherCards[0];
        PlayingCard *card2 = otherCards[1];
        if (self.rank == card1.rank&&self.rank == card2.rank) {
            score += 20;
        } else if (self.rank == card1.rank||self.rank == card2.rank||card1.rank == card2.rank){
            score += 15;
        }
        if ([self.suit isEqualToString:card1.suit]&&[self.suit isEqualToString:card2.suit]) {
            score += 10;
        } else if ([self.suit isEqualToString:card1.suit]||[self.suit isEqualToString:card2.suit]||[card1.suit isEqualToString:card2.suit]){
            score += 5;
        }
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",
             @"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit? _suit : @"?";
}

+ (NSArray *)validSuits
{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

+ (NSUInteger)maxRank
{
    NSUInteger maxRank = 13;
    return maxRank;
}

@end
