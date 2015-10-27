//
//  Track.m
//  MemoryGame
//
//  Created by         on 24/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import "Track.h"

@implementation Track

+ (id)trackWithDictionary:(NSDictionary *)dictionary
{
    Track *track = [Track new];
    track.trackID = dictionary[@"id"];
    track.userID = dictionary[@"user"][@"id"];
    track.username = dictionary[@"user"][@"username"];
    track.artworkUrl = dictionary[@"artwork_url"];
    return track;
}


@end
