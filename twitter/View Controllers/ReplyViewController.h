//
//  ReplyViewController.h
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/17/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReplyViewController : UIViewController
@property (nonatomic, strong) Tweet *replyTweet;

@end

NS_ASSUME_NONNULL_END
