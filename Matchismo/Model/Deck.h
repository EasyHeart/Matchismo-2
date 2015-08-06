//
//  Deck.h
//  Matchismo
//
//  Created by hangliu on 15/7/12.
//  Copyright © 2015年 MoonBright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
