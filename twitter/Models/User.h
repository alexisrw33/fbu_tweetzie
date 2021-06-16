//
//  User.h
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/11/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *tagLine;
@property (nonatomic, strong) NSURL* profilePicURL;
@property (nonatomic, strong) NSURL* headerPicURL;
@property (nonatomic) int followerCount;
@property (nonatomic) int friendsCount;
@property (nonatomic) int tweetCount;

-(instancetype) initWithDictionary: (NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
