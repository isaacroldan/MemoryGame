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
@property (nonatomic, strong) Track *selectedTrack;
@property (nonatomic, assign) NSInteger matches;
@end


@implementation GameController

//init the game, download everything, return the items in the block
- (void)startGameWithPermalink:(NSString *)permalink completion:(void (^)(NSArray *items))completion
{
    [[[APIClient resolveFromPermalink:permalink]
      flattenMap:^RACStream *(Track *track) {
          return [APIClient fetchTracksForUser:track.userID];
      }] subscribeNext:^(NSArray *items) {
          self.currentGame = [Game gameWithItems:items];
          completion(self.currentGame.items);
      }];
    self.selectedTrack = nil;
    self.matches = 0;
}


- (GameAction)selectTrack:(Track *)track
{
    if (!track) {
        return GameActionInvalid;
    }
    if (!self.selectedTrack) {
        self.selectedTrack = track; //first selection
        return GameActionValid;
    }
    else if (self.selectedTrack == track) {
        self.selectedTrack = nil;
        self.matches++;
        if (self.matches == self.currentGame.items.count/2) {
            return GameActionFinished; // no more matches!
        }
        return GameActionMatch; //second selection, match
    }
    else {
        self.selectedTrack = nil;
        return GameActionNoMatch; //second selection, no match
    }
}


@end
