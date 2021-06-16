//
//  DetailsViewController.h
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/15/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) Tweet *detailsTweet;

@end

NS_ASSUME_NONNULL_END
