//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by hangliu on 15/8/2.
//  Copyright (c) 2015年 MoonBright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject


//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)reset;


@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) BOOL enableHardMode;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic) NSUInteger matchedCount;

@end
