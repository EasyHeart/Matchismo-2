//
//  PlayingCard.h
//  Matchismo
//
//  Created by hangliu on 15/7/12.
//  Copyright © 2015年 MoonBright. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
