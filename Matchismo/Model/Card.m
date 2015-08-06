//
//  Card.m
//  Matchismo
//
//  Created by hangliu on 15/7/12.
//  Copyright © 2015年 MoonBright. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0 ;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
