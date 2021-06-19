//
//  DetailsViewController.m
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/15/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
#import "APIManager.h"
//#import "TimelineViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSObject *detailsTweet = [defaults objectForKey:@"details_tweet"];
    NSLog(@"%@", self.detailsTweet);
    self.tweetText.text = self.detailsTweet.text;
    self.name.text = self.detailsTweet.user.name;
    self.screenName.text = [ @"@" stringByAppendingString:self.detailsTweet.user.screenName];
    self.createdAt.text = self.detailsTweet.createdAtString;
    self.favoriteCount.text = [NSString stringWithFormat:@"%ld", (long)self.detailsTweet.favoriteCount];
    self.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)self.detailsTweet.retweetCount];
//    cell.replyCount.text = self.tweet.

    NSURL *profilePictureURL = [NSURL URLWithString:self.detailsTweet.user.profilePicture];
    NSData *data = [NSData dataWithContentsOfURL:profilePictureURL];
    UIImage *profilePicture = [UIImage imageWithData:data];
    self.profilePicture.image = profilePicture;
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.height / 2;
    self.profilePicture.layer.masksToBounds = YES;
    self.profilePicture.layer.borderWidth = 2;
}

-(void)favorite {
    [[APIManager shared]favorite:self.detailsTweet completion:^(Tweet *, NSError * error) {
        if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", self.detailsTweet);
             }
    }];
}

-(void)unfavorite {
    [[APIManager shared]unfavorite:self.detailsTweet completion:^(Tweet *, NSError *error) {
        if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", self.detailsTweet);
             }
    }];
}

-(void)retweet {
    [[APIManager shared]retweet:self.detailsTweet completion:^(Tweet *, NSError * error) {
        if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeting the following Tweet: %@", self.detailsTweet);
             }
    }];
}

-(void)unretweet {
    [[APIManager shared]unRetweet:self.detailsTweet completion:^(Tweet *, NSError *error) {
        if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeting the following Tweet: %@", self.detailsTweet);
             }
    }];
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.detailsTweet.retweeted == NO) {
        [self retweetRefreshData];
        [self retweet];
    } else {
        [self retweetRefreshData];
        [self unretweet];
    }
}
- (IBAction)didTapFav:(id)sender {
    if (self.detailsTweet.favorited == NO) {
        [self favoriteRefreshData];
        [self favorite];
    } else {
        [self favoriteRefreshData];
        [self unfavorite];
    }
}

- (void)retweetRefreshData {
    if (self.detailsTweet.retweeted == NO) {
        self.detailsTweet.retweeted = YES;
        NSInteger number = self.detailsTweet.retweetCount;
        number += 1;
        self.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.detailsTweet.retweetCount += 1;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        self.detailsTweet.retweeted = NO;
        NSInteger number = self.detailsTweet.retweetCount;
        number -= 1;
        self.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.detailsTweet.retweetCount -=1;
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }

}
- (void)favoriteRefreshData {
    
    if (self.detailsTweet.favorited == NO) {
        self.detailsTweet.favorited = YES;
        NSInteger number = self.detailsTweet.favoriteCount;
        number += 1;
        self.favoriteCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.detailsTweet.favoriteCount += 1;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        
    } else {
        self.detailsTweet.favorited = NO;
        NSInteger number = self.detailsTweet.favoriteCount;
        number -= 1;
        self.favoriteCount.text = [NSString stringWithFormat:@"%ld", (long)number];
        self.detailsTweet.favoriteCount -= 1;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
