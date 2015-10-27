//
//  NSMutableArray+Randomize.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 25/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Randomize)

/**
 Given an array, return a new array with the same objects of the first one but shuffled.
 
 - @param array NSArray to shuffle
 
 - @return new NSArray with the shuffled objects
 */
+ (NSArray *)shuffleArray:(NSArray *)array;
@end
