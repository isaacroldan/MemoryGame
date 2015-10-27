//
//  APIClient.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface APIClient : NSObject

/**
 Download the track or tracklist for a given permalink URL.
 
 - @param permalink NSString with the URL of a track or tracklist permalink
 
 - @return RACSignal that encapsulates the network request and the necessary mapping to create a Track object
 */
+ (RACSignal *)resolveFromPermalink:(NSString *)permalink;

/**
 Download the latest tracks for a given userID
 
 - @param userID Identifier of the user to download the tracks
 
 - @return RACSignal that encapsulates the network request and 
 the necessary mapping to create the NSArray of Track objects
 */
+ (RACSignal *)fetchTracksForUser:(NSNumber *)userID;
@end
