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
+ (RACSignal *)resolveFromPermalink:(NSString *)permalink;
+ (RACSignal *)fetchTracksForUser:(NSNumber *)userID;
@end
