//
//  GameController.m
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "GameController.h"
#import "Game.h"
#import "Track.h"
#import "APIClient.h"


@interface GameController()
@property (nonatomic, strong) Game *currentGame;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSMutableArray *matches;
@property (nonatomic, strong) NSMutableDictionary *matchesDict;
@end



@implementation GameController

//init the game, download everything, return the items in the block
- (void)startGameWithPermalink:(NSString *)permalink completion:(void (^)(NSArray *items, NSError *error))completion
{
    [[[APIClient resolveFromPermalink:permalink]
      flattenMap:^RACStream *(Track *track) {
          return [APIClient fetchTracksForUser:track.userID];
      }] subscribeNext:^(NSArray *items) {
          dispatch_async(dispatch_get_main_queue(), ^{
              if (items.count < 8) {
                  NSError *error = [NSError errorWithDomain:@"com.isaac" code:-1 userInfo:nil];
                  completion(@[], error);
              } else {
                  self.currentGame = [Game gameWithItems:items];
                  completion(self.currentGame.items, nil);
              }
          });
      }];
    self.selectedIndex = -1;
}

- (Track *)itemAtIndex:(NSInteger)index
{
    return self.currentGame.items[index];
}

- (BOOL)canSelectItemAtIndex:(NSInteger)index
{
    return ([self.matchesDict objectForKey:@(index)] == nil);
}

/**
 Select the item at the given index and detect if there is a match or not. 
 Calls the delegate according to the matches or fails detected.
 
 Returns a BOOL, indicating wether the item can be selected or not.
 */
- (BOOL)selectItemAtIndex:(NSInteger)index
{
    if (index >= self.currentGame.items.count) { return NO; }
    if (![self canSelectItemAtIndex:index]) { return NO; }
    Track *newTrack = self.currentGame.items[index];
    
    if (self.selectedIndex > -1 && index != self.selectedIndex) {
        Track *selectedTrack = self.currentGame.items[self.selectedIndex];
        if (selectedTrack == newTrack) {
            [self.delegate didFoundMatchAtIndex:index and:self.selectedIndex];
            [self.matchesDict setObject:@1 forKey:@(index)];
            [self.matchesDict setObject:@1 forKey:@(self.selectedIndex)];
            if (self.matchesDict.allKeys.count == self.currentGame.items.count) {
                [self.delegate didFinishGame];
            }
        }
        else {
            [self.delegate didFailToFindMatchAtIndex:index and:self.selectedIndex];
        }
        self.selectedIndex = -1;
    }
    else {
        self.selectedIndex = index;
    }
    return YES;
}

- (NSMutableDictionary *)matchesDict
{
    if (!_matchesDict) {
        _matchesDict = [NSMutableDictionary new];
    }
    return _matchesDict;
}



@end
