//
//  GameController.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, GameAction) {
    GameActionValid,
    GameActionMatch,
    GameActionNoMatch,
    GameActionInvalid,
    GameActionFinished
};


@class Track;

@interface GameController : NSObject
- (void)startGameWithPermalink:(NSString *)permalink completion:(void (^)(NSArray *items))completion;
- (GameAction)selectTrack:(Track *)track;
@end
