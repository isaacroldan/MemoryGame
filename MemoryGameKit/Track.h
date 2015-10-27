//
//  Track.h
//  MemoryGame
//
//  Created by         on 24/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property (nonatomic, strong) NSNumber *trackID;
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *artworkUrl;

/**
 Init a Track objects with a NSDictionary
 */
+ (id)trackWithDictionary:(NSDictionary *)dictionary;

@end
