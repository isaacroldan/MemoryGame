//
//  NSMutableArray+Randomize.m
//  MemoryGame
//
//  Created by         on 25/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import "NSArray+Randomize.h"

@implementation NSArray (Randomize)

+ (NSArray *)shuffleArray:(NSArray *)array
{
    NSUInteger count = [array count];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [newArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [NSArray arrayWithArray:newArray];
}

@end
