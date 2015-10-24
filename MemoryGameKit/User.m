//
//  User.m
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)userWithDictionary:(NSDictionary *)dictionary
{
    User *user = [User new];
    user.userID = dictionary[@"id"];
    user.name = dictionary[@"username"];
    return user;
}

@end
