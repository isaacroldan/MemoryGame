//
//  GameController.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Track;

@protocol GameControllerDelegate <NSObject>
- (void)didFoundMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex;
- (void)didFailToFindMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex;
- (void)didFinishGame;
@end

@interface GameController : NSObject
@property (nonatomic, weak) id<GameControllerDelegate> delegate;
- (void)startGameWithPermalink:(NSString *)permalink completion:(void (^)(NSArray *items, NSError *error))completion;
- (BOOL)selectItemAtIndex:(NSInteger)index;
- (BOOL)canSelectItemAtIndex:(NSInteger)index;
@end
