//
//  Tweet.h
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/11/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

//Properties
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) int favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) int retweetCount;
@property (nonatomic) BOOL retweeted;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *createdAtString;
@property (nonatomic, strong) NSString *media_url;

//For Rewteets
@property (nonatomic, strong) User *retweetedByUser;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
