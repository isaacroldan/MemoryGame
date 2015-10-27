//
//  Game.m
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "Game.h"
#import "NSArray+Randomize.h"


@implementation Game

+ (id)gameWithItems:(NSArray *)items {
    if (items.count < 8) {
        return nil;
    }
    Game *game = [Game new];
    NSArray *firstItems = [items subarrayWithRange:NSMakeRange(0, 8)];
    NSArray *fullArray = [firstItems arrayByAddingObjectsFromArray:firstItems];
    game.items = [NSArray shuffleArray:fullArray];
    return game;
}

- (void)reshuffle
{
    self.items = [NSArray shuffleArray:self.items];
}

@end
