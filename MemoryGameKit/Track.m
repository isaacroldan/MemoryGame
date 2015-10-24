//
//  Track.m
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "Track.h"

@implementation Track

+ (id)trackWithDictionary:(NSDictionary *)dictionary
{
    Track *track = [Track new];
    track.trackID = dictionary[@"id"];
    track.userID = dictionary[@"user"][@"id"];
    track.artworkUrl = dictionary[@"artwork_url"];
    return track;
}


@end
