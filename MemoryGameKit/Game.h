//
//  Game.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
@property (nonatomic, strong) NSArray *items;

/**
 A Game is just a collection of tracks
 Use this method to create a new Game given an array of tracks.
 If the array has less than 8 objects, the Game won´t be created.
 
 The Game will always take the first 8 objects, duplicate and shuffle them.
 
 - @param tracks NSArray of Track objects
 
 - @return an Instance of Game
 */
+ (id)gameWithItems:(NSArray *)tracks;
- (void)reshuffle;
@end
