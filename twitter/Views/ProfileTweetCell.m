//
//  ProfileTweetCell.m
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/17/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileTweetCell.h"
#import "APIManager.h"
#import "Tweet.h"

@implementation ProfileTweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)favoriteTweet {
    [[APIManager shared]favorite:self.tweet completion:^(Tweet *, NSError * error) {
        if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", self.tweet.text);
             }
    }];
}

- (void)unfavoriteTweet {
    [[APIManager shared]unfavorite:self.tweet completion:^(Tweet *, NSError * error) {
        if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", self.tweet.text);
             }
    }];
}

- (void)retweetTweet {
    [[APIManager shared]retweet:self.tweet completion:^(Tweet *, NSError * error) {
        if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", self.tweet.text);
             }
    }];
}

- (void)unRetweetTweet {
    [[APIManager shared]unRetweet:self.tweet completion:^(Tweet *, NSError * error) {
        if(error){
                  NSLog(@"Error unRetweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unRetweeted the following Tweet: %@", self.tweet.text);
             }
    }];
}
- (IBAction)didTapFav:(id)sender {
    if (self.tweet.favorited == NO) {
        [self favoriteRefreshData];
        [self favoriteTweet];
    } else {
        [self favoriteRefreshData];
        [self unfavoriteTweet];
    }
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == NO) {
        [self retweetRefreshData];
        [self retweetTweet];
    } else {
        [self retweetRefreshData];
        [self unRetweetTweet];
    }
}

- (void)retweetRefreshData {
    if (self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        NSInteger number = self.tweet.retweetCount;
        number += 1;
        self.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.tweet.retweetCount += 1;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        self.tweet.retweeted = NO;
        NSInteger number = self.tweet.retweetCount;
        number -= 1;
        self.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.tweet.retweetCount -=1;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }

}
- (void)favoriteRefreshData {
    
    if (self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        NSInteger number = self.tweet.favoriteCount;
        number += 1;
        self.favCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.tweet.favoriteCount += 1;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        
    } else {
        self.tweet.favorited = NO;
        NSInteger number = self.tweet.favoriteCount;
        number -= 1;
        self.favCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.tweet.favoriteCount -= 1;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
}

@end
