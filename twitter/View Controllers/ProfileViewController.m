//
//  ProfileViewController.m
//  twitter
//
//  Created by Alexis Rojas-Westall on 6/16/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIManager.h"
#import "User.h"
#import "Tweet.h"
#import "ProfileTweetCell.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet UIImageView *backdrop;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfProfileTweets;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAccount];
    [self getProfileTweets];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.isMoreDataLoading = false;
    // Do any additional setup after loading the view.
}
- (void)loadAccount {
    [[APIManager shared]getAccountDetails:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
            NSLog(@"%@", self.user);
            NSLog(@"😎😎😎 Successfully loaded user");
            
            self.name.text = self.user.name;
            self.screenName.text = self.user.screenName;
            self.followingCount.text = [NSString stringWithFormat:@"%d", self.user.followerCount];
            self.followerCount.text = [NSString stringWithFormat:@"%d", self.user.friendsCount];
            
        //    NSURL *profilePictureURL = [NSURL URLWithString:self.user.profilePicture];
            NSData *data = [NSData dataWithContentsOfURL:self.user.profilePicURL];
            UIImage *profilePicture = [UIImage imageWithData:data];
            self.profilePicture.image = profilePicture;
            self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.height / 2;
            self.profilePicture.layer.masksToBounds = YES;
            self.profilePicture.layer.borderWidth = 2;
            
            NSURL *backdropURL = self.user.headerPicURL;
            NSData *datas = [NSData dataWithContentsOfURL:backdropURL];
            UIImage *backdropPicture = [UIImage imageWithData:datas];
            self.backdrop.image = backdropPicture;
            
        } else {
            NSLog(@"😫😫😫 Error getting user: %@", error.localizedDescription);
        }
    }];
}
- (void)loadMoreTweets {
    Tweet *lastTweet = self.arrayOfProfileTweets.lastObject;
    NSString *maxId = lastTweet.idStr;
    
    [[APIManager shared]getUserTimelineWithCompletion:maxId completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            [self.arrayOfProfileTweets addObjectsFromArray:tweets];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
    //            for (NSDictionary *dictionary in tweets) {
    //                NSLog(@"%@",dictionary);
    //                NSString *text = dictionary[@"text"];
    //                NSLog(@"%@", text);
    //                NSString *name = dictionary[@"name"];
    //                NSLog(@"%@", name);
    //                BOOL favorited = dictionary[@"favortied"];
            [self.tableView reloadData];
    //            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
    }];
}

- (void)getProfileTweets {
    
    [[APIManager shared]getUserTimelineWithCompletion:NULL completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfProfileTweets = tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
    //            for (NSDictionary *dictionary in tweets) {
    //                NSLog(@"%@",dictionary);
    //                NSString *text = dictionary[@"text"];
    //                NSLog(@"%@", text);
    //                NSString *name = dictionary[@"name"];
    //                NSLog(@"%@", name);
    //                BOOL favorited = dictionary[@"favortied"];
            [self.tableView reloadData];
    //            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading) {
        // Calculate the position of one screen length before the bottom of the results
        int screenHeight = UIScreen.mainScreen.bounds.size.height;
        int scrollViewContentHeight = screenHeight;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
                
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadMoreTweets];

    }
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileTweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProfileTweetCell"];
    Tweet *tweet = self.arrayOfProfileTweets[indexPath.row];
    cell.tweetText.text = tweet.text;
    cell.name.text = tweet.user.name;
    cell.screenName.text = [ @"@" stringByAppendingString:tweet.user.screenName];

    cell.createdAt.text = tweet.createdAtString;
    cell.favCount.text = [NSString stringWithFormat:@"%ld", (long)tweet.favoriteCount];
    cell.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)tweet.retweetCount];

    NSURL *profilePictureURL = [NSURL URLWithString:tweet.user.profilePicture];
    NSData *data = [NSData dataWithContentsOfURL:profilePictureURL];
    UIImage *profilePicture = [UIImage imageWithData:data];
    cell.profilePicture.image = profilePicture;
    cell.profilePicture.layer.cornerRadius = cell.profilePicture.frame.size.height / 2;
    cell.profilePicture.layer.masksToBounds = YES;
    cell.profilePicture.layer.borderWidth = 2;
    
    cell.tweet = tweet;
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfProfileTweets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
