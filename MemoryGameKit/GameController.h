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

/**
 After selecting an item, (with a previously selected one) a match was found.
 
 - @param firstIndex One of the indexes where there was a match
 - @param secondIndex The other index where there was a match
 */
- (void)didFoundMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex;

/**
 After selecting an item, (with a previously selected one) a match wasn't found
 and the state should be reverted.
 
 - @param firstIndex One of the indexes where there wasn't found
 - @param secondIndex The other index where there wasn't found
 */
- (void)didFailToFindMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex;

/**
 The game has finished because all matches were found
 */
- (void)didFinishGame;
@end



/**
 GameController has all the logic for the MemoryGame
 
 You should ask it for items at a given index and will notify the `delegate`
 about matches, fails or if the game finishes.
 */
@interface GameController : NSObject
@property (nonatomic, weak) id<GameControllerDelegate> delegate;
/**
 Async method, init a new game given the permalink of a track or a tracklist.
 It will download the track or tracklist, extract the user, then download the latest tracks of that user to
 create the Game with them.
 
 Will call the completion block once everything has been downloaded and the game is ready to start.
 If the use has less than 8 valid tracks (tracks with artwortk), it will call the completion block with an error, 
 the game won't be created.
 
 - @param permalink NSString with the permalink URL of a track or tracklist object
 - @param completion Block to execute when the game is ready to start or to call if there is an error.
 */
- (void)startGameWithPermalink:(NSString *)permalink completion:(void (^)(NSArray *items, NSError *error))completion;

/**
 Select the item at the given index, will trigger the necessary calls to the delegate methods
 
 If the index is invalid or the item can't be selected, it won't do anything.
 
 - @param index NSInteger with the index of the selected object
 */
- (void)selectItemAtIndex:(NSInteger)index;

/**
 returns wether a item can be selected or not.
 An item can't be selected if was detected as a match previously, or the index is invalid.
 
 - @param index NSInteger with the index that need to be evaluated
 
 - @return YES if the object can be selected
 */
- (BOOL)canSelectItemAtIndex:(NSInteger)index;
- (NSArray *)restart;
@end
