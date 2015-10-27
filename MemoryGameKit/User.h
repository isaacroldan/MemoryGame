//
//  User.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSNumber *userID;
@property (nonatomic, strong) NSString *name;

/**
 Init a User object with a NSDictionary
 */
+ (id)userWithDictionary:(NSDictionary *)dictionary;

@end
