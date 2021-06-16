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

@interface ProfileViewController ()
@property (nonatomic, strong) User *user;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAccount];
    // Do any additional setup after loading the view.
}
- (void)loadAccount {
    [[APIManager shared]getAccountDetails:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
            NSLog(@"%@", self.user);
            NSLog(@"😎😎😎 Successfully loaded user");
            
        } else {
            NSLog(@"😫😫😫 Error getting user: %@", error.localizedDescription);
        }
    }];
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
