//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "User.h"
#import "Tweet.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "ReplyViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (nonatomic) int tweetCount;
//@property (nonatomic, strong) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.isMoreDataLoading = false;
    
    
    [self loadTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.refreshControl addTarget:self action:@selector(loadTweets) forControlEvents:UIControlEventValueChanged];

}

-(void)loadMoreData {
        
    // ... Create the NSURLRequest (myRequest) ...
    
    Tweet *lastTweet = self.arrayOfTweets.lastObject;
    NSString *maxId = lastTweet.idStr;
    
    [[APIManager shared] getHomeTimelineWithCompletion:maxId completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            // Update flag
            self.isMoreDataLoading = false;
            
            // Show new tweets
            [self.arrayOfTweets addObjectsFromArray:tweets];
            [self.tableView reloadData];
        }
            
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading) {
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
                
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadMoreData];

    }
}
}

- (void)loadTweets {
    // Get timeline
    
    [[APIManager shared] getHomeTimelineWithCompletion:NULL completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = tweets;
            self.tweetCount = tweets.count;
//            NSLog(@"%@", self.arrayOfTweets);
            for (Tweet * tweet in tweets) {
//                self.tweet = tweet;
//                self.text = tweet.text;
//                self.user = tweet.user;
//                self.name = self.user.name;
//                NSLog(@"%@", tweet.text);
                
            }
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
    
//    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}
- (IBAction)didTapLogout:(id)sender {
    [self logout];
}

- (void)logout {
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailsSegue"])
    {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *detailsTweet = self.arrayOfTweets[indexPath.row];
        UINavigationController *navController = [segue destinationViewController];
        DetailsViewController *detailsVC = navController.childViewControllers.firstObject;
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:detailsTweet forKey:@"details_tweet"];
//        [defaults synchronize];
        detailsVC.detailsTweet = detailsTweet;
    }
    
    if ([[segue identifier] isEqualToString:@"replySegue"])
    {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *replyTweet = self.arrayOfTweets[indexPath.row];
        UINavigationController *navController = [segue destinationViewController];
        ReplyViewController *replyVC = navController.childViewControllers.firstObject;
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:detailsTweet forKey:@"details_tweet"];
//        [defaults synchronize];
        replyVC.replyTweet = replyTweet;
    }
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    cell.tweetText.text = tweet.text;
    cell.name.text = tweet.user.name;
    cell.screenName.text = [ @"@" stringByAppendingString:tweet.user.screenName];
    
    if ( tweet.media_url != Nil) {
        NSURL *mediaURL = [NSURL URLWithString:tweet.media_url];
        [cell.imageMedia setImageWithURL:mediaURL];
    } else {
        cell.imageMedia.image = Nil;
    }
    
//    cell.createdAt.text = tweet.createdAtString;
    NSString *dateString = tweet.createdAtString;
//
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    NSDate *date = [formatter dateFromString:dateString];
    
    NSString *newDate = date.shortTimeAgoSinceNow;
    NSString *finalDate = [newDate stringByAppendingString:@" ago"];
    
    cell.createdAt.text = finalDate;
    
    
    
//    cell.createdAt.text = date.shortTimeAgo;
    cell.favCount.text = [NSString stringWithFormat:@"%ld", (long)tweet.favoriteCount];
    cell.retweetCount.text = [NSString stringWithFormat:@"%ld", (long)tweet.retweetCount];
//    cell.replyCount.text = self.tweet.
    
    NSURL *profilePictureURL = [NSURL URLWithString:tweet.user.profilePicture];
    NSData *data = [NSData dataWithContentsOfURL:profilePictureURL];
    UIImage *profilePicture = [UIImage imageWithData:data];
    cell.profilePicture.image = profilePicture;
    
    cell.tweet = tweet;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

@end
