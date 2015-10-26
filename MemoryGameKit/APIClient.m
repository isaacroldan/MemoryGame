//
//  APIClient.m
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "APIClient.h"
#import "Constants.h"
#import "Track.h"

@implementation APIClient

+ (RACSignal *)resolveFromPermalink:(NSString *)permalink
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:resolveEndpoint, permalink, clientID]];
    return [[self fetchFromURL:url] map:^id(NSData* value) {
        id json = [NSJSONSerialization JSONObjectWithData:value options:kNilOptions error:nil];
        if ([json isKindOfClass:[NSDictionary class]]) {
            return [Track trackWithDictionary:json];
        }
        else {
            return nil;
        }
    }];
}

+ (RACSignal *)fetchTracksForUser:(NSNumber *)userID
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:tracksEndpoint, userID, clientID]];
    return [[self fetchFromURL:url] map:^id(id value) {
        id json = [NSJSONSerialization JSONObjectWithData:value options:kNilOptions error:nil];
        if ([json isKindOfClass:[NSArray class]]) {
            NSMutableArray *mapped = [@[] mutableCopy];
            for (NSDictionary *dict in json) {
                [mapped addObject:[Track trackWithDictionary:dict]];
            }
            return mapped;
        }
        else {
            return nil;
        }
    }];
}

+ (RACSignal *)fetchFromURL:(NSURL *)url
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                              dataTaskWithURL:url
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  if (error) {
                                                      [subscriber sendError:error];
                                                  }
                                                  else {
                                                      [subscriber sendNext:data];
                                                  }
                                                  [subscriber sendCompleted];
                                              }];
        [downloadTask resume];
        return [RACDisposable disposableWithBlock:^{
            [downloadTask cancel];
        }];
    }];

}

@end
