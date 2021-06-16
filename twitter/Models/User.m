//
//  User.m
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/11/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
//        NSLog(@"%@", dictionary);
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.tagLine = dictionary[@"description"];
        self.profilePicURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.headerPicURL = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        self.friendsCount = [dictionary[@"friends_count"] intValue]; // rag: which one to use?
        self.followerCount = [dictionary[@"followers_count"] intValue];
        self.tweetCount = [dictionary[@"statuses_count"] intValue];
    }
    return self;
}

@end
