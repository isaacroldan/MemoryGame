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

+ (id)gameWithItems:(NSArray *)tracks;
@end
