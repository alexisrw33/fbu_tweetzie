//
//  ComposeViewController.h
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/14/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (nonatomic, weak) id<UITextViewDelegate> delegate;
//
//@protocol ComposeViewControllerDelegate
//
//- (void)didTweet:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END
