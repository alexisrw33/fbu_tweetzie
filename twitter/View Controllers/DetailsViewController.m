//
//  DetailsViewController.m
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/15/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
//#import "TimelineViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *createdAt;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSObject *detailsTweet = [defaults objectForKey:@"details_tweet"];
    NSLog(@"%@", self.detailsTweet);
//    self.tweetText.text = self.detailsTweet.text;
//    self.name.text = self.detailsTweet.user.name;
//    self.screenName.text = [ @"@" stringByAppendingString:self.detailsTweet.user.screenName];
//    self.createdAt.text = self.detailsTweet.createdAtString;
//    self.favoriteCount.text = [NSString stringWithFormat:@"%ld", (long)self.detailsTweet.favoriteCount];
//    self.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)self.detailsTweet.retweetCount];
////    cell.replyCount.text = self.tweet.
//
//    NSURL *profilePictureURL = [NSURL URLWithString:self.detailsTweet.user.profilePicture];
//    NSData *data = [NSData dataWithContentsOfURL:profilePictureURL];
//    UIImage *profilePicture = [UIImage imageWithData:data];
//    self.profilePicture.image = profilePicture;
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
